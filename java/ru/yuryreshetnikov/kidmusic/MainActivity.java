package ru.yuryreshetnikov.caller;

import android.preference.PreferenceActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

public class MainActivity extends PreferenceActivity {

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
	getMenuInflater().inflate(R.menu.options, menu);
	return true;
    }

    @Override
    public boolean onMenuItemSelected(int featureId, MenuItem item) {
	if(item.getItemId() == R.id.action_about) {
	    Toast.makeText(getApplicationContext(),
			   getString(R.string.toast_about),
			   Toast.LENGTH_LONG).show();
	    return true;
	}
	return super.onMenuItemSelected(featureId, item);
    }

}
