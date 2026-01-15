const fs = require('fs');

console.log('Checking HandyPro Connect setup...\n');

// Check 1: authSlice exists
console.log('1. Checking authSlice.js...');
if (fs.existsSync('src/store/slices/authSlice.js')) {
  console.log('   ✓ authSlice.js exists');
  
  const authSliceContent = fs.readFileSync('src/store/slices/authSlice.js', 'utf8');
  if (authSliceContent.includes('createSlice')) {
    console.log('   ✓ Contains createSlice');
  }
  if (authSliceContent.includes('loginSuccess')) {
    console.log('   ✓ Has loginSuccess reducer');
  }
} else {
  console.log('   ✗ authSlice.js missing!');
}

// Check 2: store.js imports authReducer
console.log('\n2. Checking store.js...');
if (fs.existsSync('src/store/store.js')) {
  console.log('   ✓ store.js exists');
  
  const storeContent = fs.readFileSync('src/store/store.js', 'utf8');
  if (storeContent.includes('authReducer')) {
    console.log('   ✓ Imports authReducer');
  }
  if (storeContent.includes('configureStore')) {
    console.log('   ✓ Uses configureStore');
  }
} else {
  console.log('   ✗ store.js missing!');
}

// Check 3: index.js has Provider
console.log('\n3. Checking index.js...');
if (fs.existsSync('src/index.js')) {
  console.log('   ✓ index.js exists');
  
  const indexContent = fs.readFileSync('src/index.js', 'utf8');
  if (indexContent.includes('Provider')) {
    console.log('   ✓ Has Redux Provider');
  }
  if (indexContent.includes('store')) {
    console.log('   ✓ Imports store');
  }
} else {
  console.log('   ✗ index.js missing!');
}

// Check 4: App.jsx has ProtectedRoute
console.log('\n4. Checking App.jsx...');
if (fs.existsSync('src/App.jsx')) {
  console.log('   ✓ App.jsx exists');
  
  const appContent = fs.readFileSync('src/App.jsx', 'utf8');
  if (appContent.includes('ProtectedRoute')) {
    console.log('   ✓ Uses ProtectedRoute');
  }
} else {
  console.log('   ✗ App.jsx missing!');
}

// Check 5: Navbar.jsx uses Redux
console.log('\n5. Checking Navbar.jsx...');
if (fs.existsSync('src/components/Navbar.jsx')) {
  console.log('   ✓ Navbar.jsx exists');
  
  const navbarContent = fs.readFileSync('src/components/Navbar.jsx', 'utf8');
  if (navbarContent.includes('useSelector')) {
    console.log('   ✓ Uses useSelector');
  }
  if (navbarContent.includes('useDispatch')) {
    console.log('   ✓ Uses useDispatch');
  }
} else {
  console.log('   ✗ Navbar.jsx missing!');
}

console.log('\nSetup check complete!');
console.log('\nTo start your app:');
console.log('1. npm install react-redux @reduxjs/toolkit axios');
console.log('2. npm start');
