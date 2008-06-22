From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: pass hw_regs_t-s to ide_device_add[_all]()
Date: Sun, 22 Jun 2008 15:22:53 +0200
Message-ID: <200806221522.53574.bzolnier@gmail.com>
References: <200806202029.11304.bzolnier@gmail.com> <Pine.LNX.4.64.0806221055210.4607@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:43044 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbYFVN5v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 09:57:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1946883fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 06:57:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806221055210.4607@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Sunday 22 June 2008, Geert Uytterhoeven wrote:
> On Fri, 20 Jun 2008, Bartlomiej Zolnierkiewicz wrote:
> > * Add 'hw_regs_t **hws' argument to ide_device_add[_all]() and convert
> >   host drivers + drivers/ide/setup-pci.c to use it instead of calling
> >   ide_init_port_hw() directly (however if host has more than 1 port we
> >   must still set hwif->chipset to hint consecutive ide_find_port() call
> >   that the ide_hwifs[] slot is occupied).
> > 
> > * Unexport ide_init_port_hw().
> > 
> > There should be no functional changes caused by this patch.
> 
> Brr... seems to complicate the bookkeeping a lot...
> 
> I looked at the m68k drivers only:
> 
> > --- a/drivers/ide/legacy/buddha.c
> > +++ b/drivers/ide/legacy/buddha.c
> > @@ -148,7 +148,6 @@ static void __init buddha_setup_ports(hw
> >  
> >  static int __init buddha_init(void)
> >  {
> > -	hw_regs_t hw;
> >  	ide_hwif_t *hwif;
> >  	int i;
> >  
> > @@ -159,6 +158,7 @@ static int __init buddha_init(void)
> >  
> >  	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> >  		unsigned long board;
> > +		hw_regs_t hw[3], *hws[] = { NULL, NULL, NULL, NULL };
> 			     ^
> max(BUDDHA_NUM_HWIFS, CATWEASEL_NUM_HWIFS, XSURF_NUM_HWIFS)
> 
> 				  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Another magic constant, hws[] always has 4 elements?

idx[] / hws[] always has 4 elements if used with ide_device_add().

[ Todays' patches will remove idx[] so the number of magic constants
  will remain constant. :) ]

> > --- a/drivers/ide/legacy/gayle.c
> > +++ b/drivers/ide/legacy/gayle.c
> > @@ -125,6 +125,7 @@ static void __init gayle_setup_ports(hw_
> >  static int __init gayle_init(void)
> >  {
> >      int a4000, i;
> > +    hw_regs_t hw[2], *hws[] = { NULL, NULL, NULL, NULL };
> 		    ^
> 		    GAYLE_NUM_HWIFS
> 
> > Index: b/drivers/ide/legacy/q40ide.c
> > ===================================================================
> > --- a/drivers/ide/legacy/q40ide.c
> > +++ b/drivers/ide/legacy/q40ide.c
> > @@ -112,7 +112,7 @@ static int __init q40ide_init(void)
> >  {
> >      int i;
> >      ide_hwif_t *hwif;
> > -    const char *name;
> > +    hw_regs_t hw[2], *hws[] = { NULL, NULL, NULL, NULL };
> 		    ^
> 		    Q40IDE_NUM_HWIFS

I revised the patch, thanks!

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: pass hw_regs_t-s to ide_device_add[_all]() (take 2)

* Add 'hw_regs_t **hws' argument to ide_device_add[_all]() and convert
  host drivers + ide_legacy_init_one() + ide_setup_pci_device[s]() to use
  it instead of calling ide_init_port_hw() directly.

  [ However if host has > 1 port we must still set hwif->chipset to hint
    consecutive ide_find_port() call that the previous slot is occupied. ]

* Unexport ide_init_port_hw().

v2:
* Use defines instead of hard-coded values in buddha.c, gayle.c and q40ide.c.
  (Suggested by Geert Uytterhoeven)

* Better patch description.

There should be no functional changes caused by this patch.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
only an interdiff from v1->v2 below

diff -u b/drivers/ide/legacy/buddha.c b/drivers/ide/legacy/buddha.c
--- b/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -37,6 +37,8 @@
 #define CATWEASEL_NUM_HWIFS	3
 #define XSURF_NUM_HWIFS         2
 
+#define MAX_NUM_HWIFS		3
+
     /*
      *  Bases of the IDE interfaces (relative to the board address)
      */
@@ -158,7 +160,7 @@
 
 	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
-		hw_regs_t hw[3], *hws[] = { NULL, NULL, NULL, NULL };
+		hw_regs_t hw[MAX_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
 		u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
diff -u b/drivers/ide/legacy/gayle.c b/drivers/ide/legacy/gayle.c
--- b/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -125,7 +125,7 @@
 static int __init gayle_init(void)
 {
     int a4000, i;
-    hw_regs_t hw[2], *hws[] = { NULL, NULL, NULL, NULL };
+    hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_AMIGA)
diff -u b/drivers/ide/legacy/q40ide.c b/drivers/ide/legacy/q40ide.c
--- b/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -112,7 +112,7 @@
 {
     int i;
     ide_hwif_t *hwif;
-    hw_regs_t hw[2], *hws[] = { NULL, NULL, NULL, NULL };
+    hw_regs_t hw[Q40IDE_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_Q40)
