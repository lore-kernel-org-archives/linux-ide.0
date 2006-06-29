From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Thu, 29 Jun 2006 19:27:15 +0200
Message-ID: <20060629172715.GA21339@gollum.tnic>
References: <20060629160926.GB23122@zmei.tnic> <44A3FF72.8090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:22676 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751064AbWF2R1S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:27:18 -0400
Content-Disposition: inline
In-Reply-To: <44A3FF72.8090404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jun 30, 2006 at 01:27:30AM +0900, Tejun Heo wrote:
<snip>
> >@@ -805,11 +807,16 @@ extern void ata_do_eh(struct ata_port *a
> > /*
> >  * printk helpers
> >  */
> >-#define ata_port_printk(ap, lv, fmt, args...) \
> >-	printk(lv"ata%u: "fmt, (ap)->id , ##args)
> >+#define ata_port_printk(ap, lv, fmt, args...) do { \
> >+	if (unlikely((ap)->msg_enable & (0xFF & (lv)))) \
>                                          ^^^^why?
Because the decimal value of ATA_MSG_TRACE, for example, is 128 (hex 0x80) and
when i shift a 1 128 time to the left, the datatype, in our case an int, i
think (dunno what gcc does exactly here) is too small for the shift. Besides,
ap->msg_enable is an u32 so that if would never be true for something bigger
than 0x20.
> >+		printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id , 
> >##args); \
> >+} while (0)
> > 
> >-#define ata_dev_printk(dev, lv, fmt, args...) \
> >-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
> >+#define ata_dev_printk(dev, lv, fmt, args...) do { \
> >+	if (unlikely((dev->ap)->msg_enable & (0xFF & (lv)))) \
>                                               ^^^^ditto
> 
> >+		printk("%sata%u.%02u: "fmt, __ata_msg_lvs[lv], \
> >+				(dev)->ap->id, (dev)->devno , ##args); \
> >+} while (0)
> > 
> > /*
> >  * ata_eh_info helpers
> >@@ -997,9 +1004,8 @@ static inline u8 ata_wait_idle(struct at
> > 
> > 	if (status & (ATA_BUSY | ATA_DRQ)) {
> > 		unsigned long l = ap->ioaddr.status_addr;
> >-		if (ata_msg_warn(ap))
> >-			printk(KERN_WARNING "ATA: abnormal status 0x%X on 
> >port 0x%lX\n",
> >-				status, l);
> >+		ata_port_printk(ap, ATA_MSG_WARN, 
> >+			"ATA: abnormal status 0x%X on port 0x%lX\n", status, 
> >l);
>                          ^^^^^ you can drop the header.
will do.

Regards,
    Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

