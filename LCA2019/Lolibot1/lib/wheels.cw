WHEELDIRECTION MACHINE O_Fwd, O_Rev {
	OPTION VALUE 0;
	OPTION last_v 0;
	OPTION max_v 32000;

	idle WHEN SELF IS moving && VALUE >= -10 && VALUE <= 10;
	rev WHEN SELF IS moving && last_v != VALUE && VALUE < -10;
	fwd WHEN SELF IS moving && last_v != VALUE && VALUE > 10;
	moving WHEN VALUE != 0;
	idle DEFAULT;

	ENTER rev { O_Fwd.VALUE := 0; last_v := VALUE; O_Rev.VALUE := max_v / 100 * (VALUE*-1); }
	ENTER fwd { O_Rev.VALUE := 0; last_v := VALUE; O_Fwd.VALUE := max_v / 100 * VALUE; }

	ENTER idle { O_Fwd.VALUE := 0; O_Rev.VALUE := 0; last_v := 0; }

}

WHEELCONTROL MACHINE IA_Wheel, C_Wheel {
	update WHEN IA_Wheel.message != C_Wheel.VALUE;
	idle DEFAULT;
	ENTER update { C_Wheel.VALUE := IA_Wheel.message; }
}
