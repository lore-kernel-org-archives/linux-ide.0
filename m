From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/7] ide: pass number of ports to ide_host_{alloc,add}()
Date: Sun, 17 May 2009 19:00:49 +0200
Message-ID: <200905171900.49991.bzolnier@gmail.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205222.28638.19386.sendpatchset@localhost.localdomain> <4A0C6A27.7010703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:44978 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZEQQ6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 12:58:24 -0400
In-Reply-To: <4A0C6A27.7010703@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 14 May 2009 20:59:51 Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Pass number of ports to ide_host_{alloc,add}() and then update
> > all users accordingly.
> 
> > There should be no functional changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/buddha.c
> > ===================================================================
> > --- a/drivers/ide/buddha.c
> > +++ b/drivers/ide/buddha.c
> > @@ -160,7 +160,7 @@ static int __init buddha_init(void)
> >  
> >  	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> >  		unsigned long board;
> > -		hw_regs_t hw[MAX_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
> > +		hw_regs_t hw[MAX_NUM_HWIFS], *hws[] = { NULL, NULL, NULL };
> 
>     I think it makes sense to just drop the NULL initializers here...
> 
> >  
> >  		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
> >  			buddha_num_hwifs = BUDDHA_NUM_HWIFS;
> > @@ -224,7 +224,7 @@ fail_base2:
> >  			hws[i] = &hw[i];
> >  		}
> >  
> > -		ide_host_add(&buddha_port_info, hws, NULL);
> > +		ide_host_add(&buddha_port_info, hws, i, NULL);
> 
>     ... since ide_host_add() won't look beyond hws[i - 1] anyway.
> 
> >  	}
> >  
> >  	return 0;
> > Index: b/drivers/ide/cmd640.c
> > ===================================================================
> > --- a/drivers/ide/cmd640.c
> > +++ b/drivers/ide/cmd640.c
> > @@ -708,7 +708,7 @@ static int __init cmd640x_init(void)
> >  	int second_port_cmd640 = 0, rc;
> >  	const char *bus_type, *port2;
> >  	u8 b, cfr;
> > -	hw_regs_t hw[2], *hws[] = { NULL, NULL, NULL, NULL };
> > +	hw_regs_t hw[2], *hws[] = { NULL, NULL };
> 
>     Same here...
> 
> > Index: b/drivers/ide/gayle.c
> > ===================================================================
> > --- a/drivers/ide/gayle.c
> > +++ b/drivers/ide/gayle.c
> > @@ -125,7 +125,7 @@ static int __init gayle_init(void)
> >      unsigned long base, ctrlport, irqport;
> >      ide_ack_intr_t *ack_intr;
> >      int a4000, i, rc;
> > -    hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[] = { NULL, NULL, NULL, NULL };
> > +    hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[] = { NULL, NULL };
> 
>     ... and here.

done in v2:

...
v2:
- drop no longer needed NULL initializers in buddha.c, cmd640.c and gayle.c
  (noticed by Sergei)
...

diff -u b/drivers/ide/buddha.c b/drivers/ide/buddha.c
--- b/drivers/ide/buddha.c
+++ b/drivers/ide/buddha.c
@@ -160,7 +160,7 @@
 
 	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
-		hw_regs_t hw[MAX_NUM_HWIFS], *hws[] = { NULL, NULL, NULL };
+		hw_regs_t hw[MAX_NUM_HWIFS], *hws[MAX_NUM_HWIFS];
 
 		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
 			buddha_num_hwifs = BUDDHA_NUM_HWIFS;
diff -u b/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
--- b/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -708,7 +708,7 @@
 	int second_port_cmd640 = 0, rc;
 	const char *bus_type, *port2;
 	u8 b, cfr;
-	hw_regs_t hw[2], *hws[] = { NULL, NULL };
+	hw_regs_t hw[2], *hws[2];
 
 	if (cmd640_vlb && probe_for_cmd640_vlb()) {
 		bus_type = "VLB";
diff -u b/drivers/ide/gayle.c b/drivers/ide/gayle.c
--- b/drivers/ide/gayle.c
+++ b/drivers/ide/gayle.c
@@ -125,7 +125,7 @@
     unsigned long base, ctrlport, irqport;
     ide_ack_intr_t *ack_intr;
     int a4000, i, rc;
-    hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[] = { NULL, NULL };
+    hw_regs_t hw[GAYLE_NUM_HWIFS], *hws[GAYLE_NUM_HWIFS];
 
     if (!MACH_IS_AMIGA)
 	return -ENODEV;
