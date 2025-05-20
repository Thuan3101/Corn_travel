// firebase.js
import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.21.0/firebase-app.js';
import { getStorage } from 'https://www.gstatic.com/firebasejs/9.21.0/firebase-storage.js';


var firebaseConfig = {
    apiKey: "AIzaSyDvWt4jTDT6qBPHGfab4gzu0gyV-u-t8ks",
    authDomain: "website-tour-1cf29.firebaseapp.com",
    projectId: "website-tour-1cf29",
    storageBucket: "website-tour-1cf29.appspot.com",
    messagingSenderId: "669480548520",
    appId: "1:669480548520:web:93be4b4883ab9a8dc7aa9d"
};

firebase.initializeApp(firebaseConfig);

export default firebase;

