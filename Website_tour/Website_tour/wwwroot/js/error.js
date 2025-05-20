// 1. Các hằng số và cấu hình
const CONFIG = {
    ERROR_PAGE: "/home/error",
    TOKEN_KEY: "token",
    ROLE_CLAIM: "http://schemas.microsoft.com/ws/2008/06/identity/claims/role",
    ROUTES: {
        ADMIN: "/admin",
        MANAGE: "/manage"
    }
};

// 2. Utility functions
const TokenUtils = {
    // Lấy token từ localStorage
    getToken: function () {
        return localStorage.getItem(CONFIG.TOKEN_KEY);
    },

    // Kiểm tra format token cơ bản
    isValidFormat: function (token) {
        if (!token || typeof token !== 'string') return false;
        const parts = token.split('.');
        return parts.length === 3;
    },

    // Giải mã JWT token
    decode: function (token) {
        try {
            if (!this.isValidFormat(token)) {
                console.error("Token format không hợp lệ");
                return null;
            }

            const base64Url = token.split('.')[1];
            const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
            const jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
                return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
            }).join(''));

            return JSON.parse(jsonPayload);
        } catch (error) {
            console.error("Lỗi khi decode token:", error);
            return null;
        }
    },

    // Kiểm tra token hết hạn
    isExpired: function (token) {
        const decoded = this.decode(token);
        if (!decoded || !decoded.exp) return true;

        const expTime = decoded.exp * 1000;
        const currentTime = Date.now();
        const isExpired = currentTime >= expTime;

        if (isExpired) {
            console.log("Token đã hết hạn vào:", new Date(expTime));
            console.log("Thời gian hiện tại:", new Date(currentTime));
        }

        return isExpired;
    }
};

// 3. Authentication Service
const AuthService = {
    // Kiểm tra trạng thái authentication
    isAuthenticated: function () {
        const token = TokenUtils.getToken();
        if (!token) {
            console.log("Không tìm thấy token");
            return false;
        }

        if (!TokenUtils.isValidFormat(token)) {
            console.log("Token không đúng format");
            return false;
        }

        if (TokenUtils.isExpired(token)) {
            console.log("Token đã hết hạn");
            return false;
        }

        return true;
    },

    // Lấy roles của user
    getUserRoles: function () {
        const token = TokenUtils.getToken();
        if (!token) return [];

        const decoded = TokenUtils.decode(token);
        if (!decoded) return [];

        const roles = decoded[CONFIG.ROLE_CLAIM];

        if (Array.isArray(roles)) {
            return roles;
        } else if (typeof roles === 'string') {
            return [roles];
        }

        return [];
    },

    // Kiểm tra user có role cụ thể không
    hasRole: function (roleRequired) {
        const userRoles = this.getUserRoles();
        return userRoles.includes(roleRequired);
    },

    // Kiểm tra user có một trong các roles không
    hasAnyRole: function (rolesRequired) {
        const userRoles = this.getUserRoles();
        return rolesRequired.some(role => userRoles.includes(role));
    }
};

// 4. Route Protection Service
const RouteProtection = {
    // Kiểm tra và xử lý quyền truy cập
    checkAccess: function (requiredRoles) {
        console.log("=== Kiểm tra quyền truy cập ===");
        console.log("Roles yêu cầu:", requiredRoles);

        if (!AuthService.isAuthenticated()) {
            console.log("Chưa xác thực");
            this.redirectToError();
            return false;
        }

        const userRoles = AuthService.getUserRoles();
        console.log("Roles của user:", userRoles);

        const hasAccess = AuthService.hasAnyRole(requiredRoles);
        console.log("Có quyền truy cập:", hasAccess);

        if (!hasAccess) {
            this.redirectToError();
            return false;
        }

        return true;
    },

    // Chuyển hướng đến trang lỗi
    redirectToError: function () {
        console.log("Chuyển hướng đến trang lỗi");
        window.location.href = CONFIG.ERROR_PAGE;
    }
};

// 5. Main Initialization
document.addEventListener("DOMContentLoaded", function () {
    try {
        console.log("=== Khởi tạo kiểm tra quyền ===");
        const currentPath = window.location.pathname;
        console.log("Đường dẫn hiện tại:", currentPath);

        // Debug information
        console.log("Token hiện tại:", TokenUtils.getToken());
        console.log("Roles hiện tại:", AuthService.getUserRoles());

        // Kiểm tra quyền theo đường dẫn
        if (currentPath.startsWith(CONFIG.ROUTES.ADMIN)) {
            console.log("Kiểm tra quyền trang admin");
            RouteProtection.checkAccess(["Admin", "Manage"]);
        }
        else if (currentPath.startsWith(CONFIG.ROUTES.MANAGE)) {
            console.log("Kiểm tra quyền trang manage");
            RouteProtection.checkAccess(["Manage"]);
        }
        else {
            console.log("Đường dẫn không cần kiểm tra quyền đặc biệt");
        }

    } catch (error) {
        console.error("Lỗi trong quá trình kiểm tra quyền:", error);
        RouteProtection.redirectToError();
    }
});

// 6. Debugging Helper
const DebugHelper = {
    logTokenInfo: function () {
        const token = TokenUtils.getToken();
        console.log("=== Token Debug Info ===");
        console.log("Raw token:", token);
        console.log("Is valid format:", TokenUtils.isValidFormat(token));
        console.log("Decoded token:", TokenUtils.decode(token));
        console.log("Is expired:", TokenUtils.isExpired(token));
        console.log("User roles:", AuthService.getUserRoles());
        console.log("=====================");
    }
};

// Thêm vào window để có thể gọi từ console để debug
window.debugAuth = DebugHelper;