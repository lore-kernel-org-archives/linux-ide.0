From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Wed, 24 Sep 2008 09:10:55 +0200
Message-ID: <20080924071055.GB16949@gollum.tnic>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com> <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com> <20080922204129.GA3495@localhost> <48D80949.4080901@ru.mvista.com> <20080923074845.GB5656@gollum.tnic> <20080923165914.GA7803@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYIXHK7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 03:10:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1989633fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 00:10:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080923165914.GA7803@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Mark de Wever <koraq@xs4all.nl>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 23, 2008 at 06:59:14PM +0200, Mark de Wever wrote:
> On Tue, Sep 23, 2008 at 09:48:45AM +0200, Borislav Petkov wrote:
> > ---
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index 1bce84b..3833189 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -2338,7 +2338,7 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
> >  {
> >  	idetape_tape_t *tape = drive->driver_data;
> >  	struct ide_atapi_pc pc;
> > -	char fw_rev[6], vendor_id[10], product_id[18];
> > +	char fw_rev[4], vendor_id[8], product_id[16];
> >  
> >  	idetape_create_inquiry_cmd(&pc);
> >  	if (idetape_queue_pc_tail(drive, &pc)) {
> > @@ -2350,11 +2350,11 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
> >  	memcpy(product_id, &pc.buf[16], 16);
> >  	memcpy(fw_rev, &pc.buf[32], 4);
> >  
> > -	ide_fixstring(vendor_id, 10, 0);
> > -	ide_fixstring(product_id, 18, 0);
> > -	ide_fixstring(fw_rev, 6, 0);
> > +	ide_fixstring(vendor_id, 8, 0);
> > +	ide_fixstring(product_id, 16, 0);
> > +	ide_fixstring(fw_rev, 4, 0);
> >  
> > -	printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",
> > +	printk(KERN_INFO "ide-tape: %s <-> %s: %.8s %.16s rev %.4s\n",
> >  			drive->name, tape->name, vendor_id, product_id, fw_rev);
> >  }
> >  
> >
> 
> I think this patch looks good, better as all previous versions
> (including my initial version). I just tested it and it solves the
> problem. Feel free to add my tested-by.
> 
> Regards,
> Mark de Wever
> 
> PS I was not able to test earlier ;-)

Bart,

please apply the following patch.

@Sergei: would you like to add your Signed-off-by too?

--
Subject: ide-tape: fix vendor strings

Remove superfluous two bytes from each string buffer and add proper length
format specifiers.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Tested-by: Mark de Wever <koraq@xs4all.nl>

--

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1bce84b..3833189 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2338,7 +2338,7 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct ide_atapi_pc pc;
-	char fw_rev[6], vendor_id[10], product_id[18];
+	char fw_rev[4], vendor_id[8], product_id[16];
 
 	idetape_create_inquiry_cmd(&pc);
 	if (idetape_queue_pc_tail(drive, &pc)) {
@@ -2350,11 +2350,11 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
 	memcpy(product_id, &pc.buf[16], 16);
 	memcpy(fw_rev, &pc.buf[32], 4);
 
-	ide_fixstring(vendor_id, 10, 0);
-	ide_fixstring(product_id, 18, 0);
-	ide_fixstring(fw_rev, 6, 0);
+	ide_fixstring(vendor_id, 8, 0);
+	ide_fixstring(product_id, 16, 0);
+	ide_fixstring(fw_rev, 4, 0);
 
-	printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",
+	printk(KERN_INFO "ide-tape: %s <-> %s: %.8s %.16s rev %.4s\n",
 			drive->name, tape->name, vendor_id, product_id, fw_rev);
 }
 

-- 
Regards/Gruss,
    Boris.
