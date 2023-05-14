Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA08C7EE23
	for <linux-ide@archiver.kernel.org>; Sun, 14 May 2023 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjENWBZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 May 2023 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjENWBX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 May 2023 18:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E17E68
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 15:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32C260F8F
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 22:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A564EC433D2;
        Sun, 14 May 2023 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684101681;
        bh=E9A3QF31/l5nIrUpKC+EfTpNjEZPqrDrHkPGxF5JQ5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QycpqT2KMIdkllZaNu9Cxl1NiH4mAgAEefi4+opgx898eyB4CdLFlqlGOgObMQUcJ
         rZNKv3JW4opVfzmHV/DiFamgDP7EszYGc7UDhDZkPUwz228Wo8fTZwN6XpcBqByxq8
         in3B0IwJ8u6uQVB8L5Su4fQytGdoiVV3lMnTRIBPSsaZAq0f2glGiDPTlAjzRHemrq
         L9tnWwfNZasU4AFXKkpsxNMfcHANJAZwCT11IzF03WGjr5K4h/PJnUElb+YEhaXa11
         hLY4HNWaFwzRYjoEwpFxOdUjKv9Xl0iSAe5X0ZPIr/wOqvhCWII4zQawMzgwr6lOZB
         riFi+m2UpFx7Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/2] ata: pata_parport: Fix bpck module code indentation and style
Date:   Mon, 15 May 2023 07:01:17 +0900
Message-Id: <20230514220118.114385-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514220118.114385-1-dlemoal@kernel.org>
References: <20230514220118.114385-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix indentation and coding style in the bpck pata parport protocol
module to suppress smatch warnings such as:

drivers/ata/pata_parport/bpck.c:66 bpck_read_regr() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305021913.nCMzH5Zj-lkp@intel.com/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/bpck.c | 446 ++++++++++++++++++--------------
 1 file changed, 256 insertions(+), 190 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 1c5035a09554..81b6b19fa99f 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* 
-	bpck.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
-		            Under the terms of the GNU General Public License.
-
-	bpck.c is a low-level protocol driver for the MicroSolutions 
-	"backpack" parallel port IDE adapter.  
-
-*/
+ * (c) 1996-8  Grant R. Guenther <grant@torque.net>
+ *
+ * bpck.c is a low-level protocol driver for the MicroSolutions
+ * "backpack" parallel port IDE adapter.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -29,36 +28,36 @@
 
 #define j44(l,h)     (((l>>3)&0x7)|((l>>4)&0x8)|((h<<1)&0x70)|(h&0x80))
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-   cont = 2 - use internal bpck register addressing
-*/
-
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ * cont = 2 - use internal bpck register addressing
+ */
 static int  cont_map[3] = { 0x40, 0x48, 0 };
 
 static int bpck_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{       int r, l, h;
+{
+	int r, l, h;
 
 	r = regr + cont_map[cont];
 
 	switch (pi->mode) {
-
-	case 0: w0(r & 0xf); w0(r); t2(2); t2(4);
+	case 0:
+		w0(r & 0xf); w0(r); t2(2); t2(4);
 	        l = r1();
-        	t2(4);
-        	h = r1();
-        	return j44(l,h);
-
-	case 1: w0(r & 0xf); w0(r); t2(2);
-	        e2(); t2(0x20);
+		t2(4);
+		h = r1();
+		return j44(l, h);
+	case 1:
+		w0(r & 0xf); w0(r); t2(2);
+		e2(); t2(0x20);
 		t2(4); h = r0();
-	        t2(1); t2(0x20);
-	        return h;
-
+		t2(1); t2(0x20);
+		return h;
 	case 2:
 	case 3:
-	case 4: w0(r); w2(9); w2(0); w2(0x20);
+	case 4:
+		w0(r); w2(9); w2(0); w2(0x20);
 		h = r4();
 		w2(0);
 		return h;
@@ -68,20 +67,18 @@ static int bpck_read_regr(struct pi_adapter *pi, int cont, int regr)
 }	
 
 static void bpck_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	int	r;
+{
+	int r;
 
         r = regr + cont_map[cont];
 
 	switch (pi->mode) {
-
 	case 0:
 	case 1: w0(r);
 		t2(2);
 		w0(val);
 		o2(); t2(4); t2(1);
 		break;
-
 	case 2:
 	case 3:
 	case 4: w0(r); w2(9); w2(0);
@@ -97,96 +94,121 @@ static void bpck_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 #define RR(r)		(bpck_read_regr(pi,2,r))
 
 static void bpck_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int i;
+{
+	int i;
 
 	switch (pi->mode) {
 
-	case 0: WR(4,0x40);
+	case 0:
+		WR(4, 0x40);
 		w0(0x40); t2(2); t2(1);
-		for (i=0;i<count;i++) { w0(buf[i]); t2(4); }
-		WR(4,0);
+		for (i = 0; i < count; i++) {
+			w0(buf[i]);
+			t2(4);
+		}
+		WR(4, 0);
 		break;
 
-	case 1: WR(4,0x50);
-                w0(0x40); t2(2); t2(1);
-                for (i=0;i<count;i++) { w0(buf[i]); t2(4); }
-                WR(4,0x10);
+	case 1:
+		WR(4, 0x50);
+		w0(0x40); t2(2); t2(1);
+		for (i = 0; i < count; i++) {
+			w0(buf[i]);
+			t2(4);
+		}
+		WR(4, 0x10);
 		break;
 
-	case 2: WR(4,0x48);
+	case 2:
+		WR(4, 0x48);
 		w0(0x40); w2(9); w2(0); w2(1);
-		for (i=0;i<count;i++) w4(buf[i]);
+		for (i = 0; i < count; i++)
+			w4(buf[i]);
 		w2(0);
-		WR(4,8);
+		WR(4, 8);
 		break;
 
-        case 3: WR(4,0x48);
-                w0(0x40); w2(9); w2(0); w2(1);
-                for (i=0;i<count/2;i++) w4w(((u16 *)buf)[i]);
-                w2(0);
-                WR(4,8);
-                break;
+	case 3:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(1);
+		for (i = 0; i < count / 2; i++)
+			w4w(((u16 *)buf)[i]);
+		w2(0);
+		WR(4, 8);
+		break;
  
-        case 4: WR(4,0x48);
-                w0(0x40); w2(9); w2(0); w2(1);
-                for (i=0;i<count/4;i++) w4l(((u32 *)buf)[i]);
-                w2(0);
-                WR(4,8);
-                break;
+	case 4:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(1);
+		for (i = 0; i < count / 4; i++)
+			w4l(((u32 *)buf)[i]);
+		w2(0);
+		WR(4, 8);
+		break;
  	}
 }
 
 static void bpck_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int i, l, h;
+{
+	int i, l, h;
 
 	switch (pi->mode) {
 
-      	case 0: WR(4,0x40);
+	case 0:
+		WR(4, 0x40);
 		w0(0x40); t2(2);
-		for (i=0;i<count;i++) {
-		    t2(4); l = r1();
-		    t2(4); h = r1();
-		    buf[i] = j44(l,h);
+		for (i = 0; i < count; i++) {
+			t2(4); l = r1();
+			t2(4); h = r1();
+			buf[i] = j44(l, h);
 		}
-		WR(4,0);
+		WR(4, 0);
 		break;
 
-	case 1: WR(4,0x50);
+	case 1:
+		WR(4, 0x50);
 		w0(0x40); t2(2); t2(0x20);
-      	        for(i=0;i<count;i++) { t2(4); buf[i] = r0(); }
-	        t2(1); t2(0x20);
-	        WR(4,0x10);
+		for (i = 0; i < count; i++) {
+			t2(4);
+			buf[i] = r0();
+		}
+		t2(1); t2(0x20);
+		WR(4, 0x10);
 		break;
 
-	case 2: WR(4,0x48);
+	case 2:
+		WR(4, 0x48);
 		w0(0x40); w2(9); w2(0); w2(0x20);
-		for (i=0;i<count;i++) buf[i] = r4();
+		for (i = 0; i < count; i++)
+			buf[i] = r4();
 		w2(0);
-		WR(4,8);
+		WR(4, 8);
 		break;
 
-        case 3: WR(4,0x48);
-                w0(0x40); w2(9); w2(0); w2(0x20);
-                for (i=0;i<count/2;i++) ((u16 *)buf)[i] = r4w();
-                w2(0);
-                WR(4,8);
-                break;
+	case 3:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(0x20);
+		for (i = 0; i < count / 2; i++)
+			((u16 *)buf)[i] = r4w();
+		w2(0);
+		WR(4, 8);
+		break;
 
-        case 4: WR(4,0x48);
-                w0(0x40); w2(9); w2(0); w2(0x20);
-                for (i=0;i<count/4;i++) ((u32 *)buf)[i] = r4l();
-                w2(0);
-                WR(4,8);
-                break;
+	case 4:
+		WR(4, 0x48);
+		w0(0x40); w2(9); w2(0); w2(0x20);
+		for (i = 0; i < count / 4; i++)
+			((u32 *)buf)[i] = r4l();
+		w2(0);
+		WR(4, 8);
+		break;
 
 	}
 }
 
 static int bpck_probe_unit(struct pi_adapter *pi)
-
-{	int o1, o0, f7, id;
+{
+	int o1, o0, f7, id;
 	int t, s;
 
 	id = pi->unit;
@@ -198,7 +220,10 @@ static int bpck_probe_unit(struct pi_adapter *pi)
 	t2(8); t2(8); t2(8);
 	t2(2); t = r1()&0xf8;
 	f7 = ((id % 8) == 7);
-	if ((f7) || (t != o1)) { t2(2); s = r1()&0xf8; }
+	if ((f7) || (t != o1)) {
+		t2(2);
+		s = r1() & 0xf8;
+	}
 	if ((t == o1) && ((!f7) || (s == o1)))  {
 		w2(0x4c); w0(o0);
 		return 0;	
@@ -208,99 +233,110 @@ static int bpck_probe_unit(struct pi_adapter *pi)
 }
 	
 static void bpck_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
+{
+	pi->saved_r0 = r0();
 	w0(0xff-pi->unit); w2(4); w0(pi->unit);
 	t2(8); t2(8); t2(8); 
 	t2(2); t2(2);
 	
 	switch (pi->mode) {
-
-	case 0: t2(8); WR(4,0);
+	case 0:
+		t2(8); WR(4, 0);
 		break;
-
-	case 1: t2(8); WR(4,0x10);
+	case 1:
+		t2(8); WR(4, 0x10);
 		break;
-
 	case 2:
-        case 3:
-	case 4: w2(0); WR(4,8);
+	case 3:
+	case 4:
+		w2(0); WR(4, 8);
 		break;
-
 	}
 
 	WR(5,8);
 
-/*	if (pi->devtype == PI_PCD) {	possibly wrong, purpose unknown */
-		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
-		WR(0x4c,0x38);
-		WR(0x4d,0x88);
-		WR(0x46,0xa0);
-		WR(0x41,0);
-		WR(0x4e,8);
-/*	}*/
+	/*
+	 * Possibly wrong, purpose unknown (fiddle with ESS logic ???)
+	 * if (pi->devtype == PI_PCD) {
+	 */
+	WR(0x46, 0x10);
+	WR(0x4c, 0x38);
+	WR(0x4d, 0x88);
+	WR(0x46, 0xa0);
+	WR(0x41, 0);
+	WR(0x4e, 8);
+	/* } */
 }
 
 static void bpck_disconnect(struct pi_adapter *pi)
-
-{	w0(0); 
-	if (pi->mode >= 2) { w2(9); w2(0); } else t2(2);
+{
+	w0(0);
+	if (pi->mode >= 2) {
+		w2(9); w2(0);
+	} else {
+		t2(2);
+	}
 	w2(0x4c); w0(pi->saved_r0);
 } 
 
 static void bpck_force_spp(struct pi_adapter *pi)
+{
+	/* This fakes the EPP protocol to turn off EPP ... */
+	pi->saved_r0 = r0();
+	w0(0xff-pi->unit); w2(4); w0(pi->unit);
+	t2(8); t2(8); t2(8);
+	t2(2); t2(2);
 
-/* This fakes the EPP protocol to turn off EPP ... */
-
-{       pi->saved_r0 = r0();
-        w0(0xff-pi->unit); w2(4); w0(pi->unit);
-        t2(8); t2(8); t2(8); 
-        t2(2); t2(2);
-
-        w2(0); 
-        w0(4); w2(9); w2(0); 
-        w0(0); w2(1); w2(3); w2(0);     
-        w0(0); w2(9); w2(0);
-        w2(0x4c); w0(pi->saved_r0);
+	w2(0);
+	w0(4); w2(9); w2(0);
+	w0(0); w2(1); w2(3); w2(0);
+	w0(0); w2(9); w2(0);
+	w2(0x4c); w0(pi->saved_r0);
 }
 
 #define TEST_LEN  16
 
 static int bpck_test_proto(struct pi_adapter *pi)
-
-{	int i, e, l, h, om;
+{
+	int i, e, l, h, om;
 	char buf[TEST_LEN];
 
 	bpck_force_spp(pi);
 
 	switch (pi->mode) {
 
-	case 0: bpck_connect(pi);
-		WR(0x13,0x7f);
+	case 0:
+		bpck_connect(pi);
+		WR(0x13, 0x7f);
 		w0(0x13); t2(2);
-		for(i=0;i<TEST_LEN;i++) {
-                    t2(4); l = r1();
-                    t2(4); h = r1();
-                    buf[i] = j44(l,h);
+		for (i = 0; i < TEST_LEN; i++) {
+			t2(4); l = r1();
+			t2(4); h = r1();
+			buf[i] = j44(l, h);
 		}
 		bpck_disconnect(pi);
 		break;
 
-        case 1: bpck_connect(pi);
-		WR(0x13,0x7f);
-                w0(0x13); t2(2); t2(0x20);
-                for(i=0;i<TEST_LEN;i++) { t2(4); buf[i] = r0(); }
-                t2(1); t2(0x20);
+	case 1:
+		bpck_connect(pi);
+		WR(0x13, 0x7f);
+		w0(0x13); t2(2); t2(0x20);
+		for (i = 0; i < TEST_LEN; i++) {
+			t2(4);
+			buf[i] = r0();
+		}
+		t2(1); t2(0x20);
 		bpck_disconnect(pi);
 		break;
 
 	case 2:
 	case 3:
-	case 4: om = pi->mode;
+	case 4:
+		om = pi->mode;
 		pi->mode = 0;
 		bpck_connect(pi);
-		WR(7,3);
-		WR(4,8);
+		WR(7, 3);
+		WR(4, 8);
 		bpck_disconnect(pi);
 
 		pi->mode = om;
@@ -308,34 +344,44 @@ static int bpck_test_proto(struct pi_adapter *pi)
 		w0(0x13); w2(9); w2(1); w0(0); w2(3); w2(0); w2(0xe0);
 
 		switch (pi->mode) {
-		  case 2: for (i=0;i<TEST_LEN;i++) buf[i] = r4();
-			  break;
-		  case 3: for (i=0;i<TEST_LEN/2;i++) ((u16 *)buf)[i] = r4w();
-                          break;
-		  case 4: for (i=0;i<TEST_LEN/4;i++) ((u32 *)buf)[i] = r4l();
-                          break;
+		case 2:
+			for (i = 0; i < TEST_LEN; i++)
+				buf[i] = r4();
+			break;
+		case 3:
+			for (i = 0; i < TEST_LEN / 2; i++)
+				((u16 *)buf)[i] = r4w();
+			break;
+		case 4:
+			for (i = 0; i < TEST_LEN / 4; i++)
+				((u32 *)buf)[i] = r4l();
+			break;
 		}
 
 		w2(0);
-		WR(7,0);
+		WR(7, 0);
 		bpck_disconnect(pi);
-
 		break;
 
 	}
 
 	dev_dbg(&pi->dev, "bpck: 0x%x unit %d mode %d: ",
 		pi->port, pi->unit, pi->mode);
-	print_hex_dump_debug("bpck: ", DUMP_PREFIX_NONE, TEST_LEN, 1, buf, TEST_LEN, false);
+	print_hex_dump_debug("bpck: ", DUMP_PREFIX_NONE, TEST_LEN, 1, buf,
+			     TEST_LEN, false);
 
 	e = 0;
-	for (i=0;i<TEST_LEN;i++) if (buf[i] != (i+1)) e++;
+	for (i = 0; i < TEST_LEN; i++) {
+		if (buf[i] != i + 1)
+			e++;
+	}
+
 	return e;
 }
 
 static void bpck_read_eeprom(struct pi_adapter *pi, char *buf)
-
-{       int i, j, k, p, v, f, om, od;
+{
+	int i, j, k, p, v, f, om, od;
 
 	bpck_force_spp(pi);
 
@@ -344,76 +390,96 @@ static void bpck_read_eeprom(struct pi_adapter *pi, char *buf)
 
 	bpck_connect(pi);
 	
-	WR(4,0);
-	for (i=0;i<64;i++) {
-	    WR(6,8);  
-	    WR(6,0xc);
-	    p = 0x100;
-	    for (k=0;k<9;k++) {
-		f = (((i + 0x180) & p) != 0) * 2;
-		WR(6,f+0xc); 
-		WR(6,f+0xd); 
-		WR(6,f+0xc);
-		p = (p >> 1);
-	    }
-	    for (j=0;j<2;j++) {
-		v = 0;
-		for (k=0;k<8;k++) {
-		    WR(6,0xc); 
-		    WR(6,0xd); 
-		    WR(6,0xc); 
-		    f = RR(0);
-		    v = 2*v + (f == 0x84);
+	WR(4, 0);
+	for (i = 0; i < 64; i++) {
+		WR(6, 8);
+		WR(6, 0xc);
+		p = 0x100;
+		for (k = 0; k < 9; k++) {
+			f = (((i + 0x180) & p) != 0) * 2;
+			WR(6, f + 0xc);
+			WR(6, f + 0xd);
+			WR(6, f + 0xc);
+			p = (p >> 1);
+		}
+		for (j = 0; j < 2; j++) {
+			v = 0;
+			for (k = 0; k < 8; k++) {
+				WR(6, 0xc);
+				WR(6, 0xd);
+				WR(6, 0xc);
+				f = RR(0);
+				v = 2 * v + (f == 0x84);
+			}
+			buf[2 * i + 1 - j] = v;
 		}
-		buf[2*i+1-j] = v;
-	    }
 	}
-	WR(6,8);
-	WR(6,0);
-	WR(5,8);
+	WR(6, 8);
+	WR(6, 0);
+	WR(5, 8);
 
 	bpck_disconnect(pi);
 
         if (om >= 2) {
-                bpck_connect(pi);
-                WR(7,3);
-                WR(4,8);
-                bpck_disconnect(pi);
+		bpck_connect(pi);
+		WR(7, 3);
+		WR(4, 8);
+		bpck_disconnect(pi);
         }
 
 	pi->mode = om; pi->delay = od;
 }
 
-static int bpck_test_port(struct pi_adapter *pi)	/* check for 8-bit port */
-
-{	int	i, r, m;
+static int bpck_test_port(struct pi_adapter *pi)
+{
+	int i, r, m;
 
+	/* Check for 8-bit port */
 	w2(0x2c); i = r0(); w0(255-i); r = r0(); w0(i);
 	m = -1;
-	if (r == i) m = 2;
-	if (r == (255-i)) m = 0;
-
-	w2(0xc); i = r0(); w0(255-i); r = r0(); w0(i);
-	if (r != (255-i)) m = -1;
+	if (r == i)
+		m = 2;
+	if (r == (255-i))
+		m = 0;
+
+	w2(0xc);
+	i = r0();
+	w0(255-i);
+	r = r0();
+	w0(i);
+	if (r != (255-i))
+		m = -1;
 	
-	if (m == 0) { w2(6); w2(0xc); r = r0(); w0(0xaa); w0(r); w0(0xaa); }
-	if (m == 2) { w2(0x26); w2(0xc); }
+	if (m == 0) {
+		w2(6);
+		w2(0xc);
+		r = r0();
+		w0(0xaa);
+		w0(r);
+		w0(0xaa);
+	}
+	if (m == 2) {
+		w2(0x26);
+		w2(0xc);
+	}
+
+	if (m == -1)
+		return 0;
 
-	if (m == -1) return 0;
 	return 5;
 }
 
 static void bpck_log_adapter(struct pi_adapter *pi)
-
-{	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
-				    "EPP-16","EPP-32" };
+{
+	char *mode_str[5] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 	char scratch[128];
 
 	bpck_read_eeprom(pi,scratch);
 	print_hex_dump_bytes("bpck EEPROM: ", DUMP_PREFIX_NONE, scratch, 128);
-	dev_info(&pi->dev, "backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
+	dev_info(&pi->dev,
+		 "backpack %8.8s unit %d at 0x%x, mode %d (%s), delay %d\n",
 		 &scratch[110], pi->unit, pi->port, pi->mode,
-		 mode_string[pi->mode], pi->delay);
+		 mode_str[pi->mode], pi->delay);
 }
 
 static struct pi_protocol bpck = {
-- 
2.40.1

