// HomeScreen.js
// Welcome screen for Semptify

import React from 'react';

function HomeScreen() {
  return (
    <div style={styles.container}>
      <h1>Semptify</h1>
      <p>Your Tenant Rights Ally</p>
      <p>Protecting renters. Empowering communities. No one left behind.</p>
    </div>
  );
}

const styles = {
  container: {
    textAlign: 'center',
    marginTop: '100px',
    fontFamily: 'Arial, sans-serif',
  },
};

export default HomeScreen;
