From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/4] : More use DIV_ROUND_UP
Date: Sat, 16 Feb 2008 15:49:07 +0100 (MET)
Message-ID: <Pine.LNX.4.58.0802161548370.1185@pc-041.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757553AbYBPOt1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The kernel.h macro DIV_ROUND_UP performs the computation (((n) + (d) - 1) /
(d)) but is perhaps more readable.

An extract of the semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
expression n,d;
@@

(
- (n + d - 1) / d
+ DIV_ROUND_UP(n,d)
|
- (n + (d - 1)) / d
+ DIV_ROUND_UP(n,d)
)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP((n),d)
+ DIV_ROUND_UP(n,d)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP(n,(d))
+ DIV_ROUND_UP(n,d)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/drivers/ide/arm/palm_bk3710.c b/drivers/ide/arm/palm_bk3710.c
--- a/drivers/ide/arm/palm_bk3710.c 2008-02-13 20:42:50.000000000 +0100
+++ b/drivers/ide/arm/palm_bk3710.c 2008-02-15 22:25:33.000000000 +0100
@@ -96,11 +96,11 @@ static void palm_bk3710_setudmamode(void
 	u16 val16;

 	/* DMA Data Setup */
-	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
-			/ ide_palm_clk - 1;
-	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
-	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
-			/ ide_palm_clk - 1;
+	t0 = DIV_ROUND_UP(palm_bk3710_udmatimings[mode].cycletime,
+			  ide_palm_clk) - 1;
+	tenv = DIV_ROUND_UP(20, ide_palm_clk) - 1;
+	trp = DIV_ROUND_UP(palm_bk3710_udmatimings[mode].rptime,
+			   ide_palm_clk) - 1;

 	/* udmatim Register */
 	val16 = readw(base + BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
@@ -141,8 +141,8 @@ static void palm_bk3710_setdmamode(void
 	cycletime = max_t(int, t->cycle, min_cycle);

 	/* DMA Data Setup */
-	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
-	td = (t->active + ide_palm_clk - 1) / ide_palm_clk;
+	t0 = DIV_ROUND_UP(cycletime, ide_palm_clk);
+	td = DIV_ROUND_UP(t->active, ide_palm_clk);
 	tkw = t0 - td - 1;
 	td -= 1;

@@ -168,9 +168,9 @@ static void palm_bk3710_setpiomode(void
 	struct ide_timing *t;

 	/* PIO Data Setup */
-	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
-	t2 = (ide_timing_find_mode(XFER_PIO_0 + mode)->active +
-	      ide_palm_clk - 1)	/ ide_palm_clk;
+	t0 = DIV_ROUND_UP(cycletime, ide_palm_clk);
+	t2 = DIV_ROUND_UP(ide_timing_find_mode(XFER_PIO_0 + mode)->active,
+			  ide_palm_clk);

 	t2i = t0 - t2 - 1;
 	t2 -= 1;
@@ -192,8 +192,8 @@ static void palm_bk3710_setpiomode(void

 	/* TASKFILE Setup */
 	t = ide_timing_find_mode(XFER_PIO_0 + mode);
-	t0 = (t->cyc8b + ide_palm_clk - 1) / ide_palm_clk;
-	t2 = (t->act8b + ide_palm_clk - 1) / ide_palm_clk;
+	t0 = DIV_ROUND_UP(t->cyc8b, ide_palm_clk);
+	t2 = DIV_ROUND_UP(t->act8b, ide_palm_clk);

 	t2i = t0 - t2 - 1;
 	t2 -= 1;
diff -u -p a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
--- a/drivers/ide/pci/cmd640.c 2008-02-08 08:58:12.000000000 +0100
+++ b/drivers/ide/pci/cmd640.c 2008-02-15 22:25:38.000000000 +0100
@@ -584,15 +584,15 @@ static void cmd640_set_mode (unsigned in
 	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
 	clock_time = 1000 / bus_speed;
-	cycle_count = (cycle_time + clock_time - 1) / clock_time;
+	cycle_count = DIV_ROUND_UP(cycle_time, clock_time);

-	setup_count = (setup_time + clock_time - 1) / clock_time;
+	setup_count = DIV_ROUND_UP(setup_time, clock_time);

-	active_count = (active_time + clock_time - 1) / clock_time;
+	active_count = DIV_ROUND_UP(active_time, clock_time);
 	if (active_count < 2)
 		active_count = 2; /* minimum allowed by cmd640 */

-	recovery_count = (recovery_time + clock_time - 1) / clock_time;
+	recovery_count = DIV_ROUND_UP(recovery_time, clock_time);
 	recovery_count2 = cycle_count - (setup_count + active_count);
 	if (recovery_count2 > recovery_count)
 		recovery_count = recovery_count2;
