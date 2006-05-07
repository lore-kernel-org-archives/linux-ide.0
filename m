From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 21:19:29 +0900
Message-ID: <445DE5D1.3010203@gmail.com>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>	<445D6298.7090003@gmail.com> <20060507140443.7ae89a68.moe@lunar-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030906020207000105050100"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:16530 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932132AbWEGMT7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 08:19:59 -0400
Received: by nz-out-0102.google.com with SMTP id 13so997698nzn
        for <linux-ide@vger.kernel.org>; Sun, 07 May 2006 05:19:58 -0700 (PDT)
In-Reply-To: <20060507140443.7ae89a68.moe@lunar-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906020207000105050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Moritz Heiber wrote:
> On Sun, 07 May 2006 11:59:36 +0900
>> What does the BIOS say exactly?  SATA II is a vague term.  It
>> comprises several features.  Some call NCQ-capable drives SATA-II
>> while others consider 3.0Gbps link SATA-II.
> 
> The manufacturer's url [1] states the following:
> 
> "PCI E SATA2 controller on board, optimizing the support for SATA2 HDD"
> 
> The BIOS and the manual [2] also state a speed advantage of 3.0Gbps.
> 
> [1] http://www.asrock.com/product/939Dual-SATA2.htm
> [2] http://www.asrock.com/Drivers/Manual/939Dual-SATA2.pdf
>     (Page 6)
> 

Hmmm...

[..snip..]
>> * both the controller and drive support 3Gbps but somehow they fail
>> to negotiate at that speed.
> 
> I guess that is the most likely explainations. Any way of solving that
> issue?

If this is the cause, it's a hardware problem.  Driver doesn't play any 
role in PHY spd negotiation other than limiting the top speed.

>> * BIOS limits link spd to 1.5Gbps using SControl in the hope for 
>> improving compatibility
> 
> Giving that a thought .. the board's only PCIe slot is already occupied
> by a pretty advanced video card. Could it be that the _bus_ is simply
> outrun in terms of available bandwidth?

No, completely unrelated.

>> More info can be obtained by printing SCR_CONTROL, just print the
>> result of scr_read(ap, SCR_CONTROL) from
>> libata.c::sata_print_link_status(), which prints the SStatus value.
> 
> I'm going to try to follow that lead. There doesn't seem to be any sort
> of tool or application that runs the exact same test yet, is there?
> hdparm fails on me.

Heh heh... I should have attached a patch for this.  I was too lazy. 
I'm attaching one on this mail.

>> Whatever the reason is, don't torture yourself over it.  It simply
>> isn't worth.  1.5Gbps is more than enough for any drive on market
>> today.
> 
> Well, I'm just making an effort to get the best out of the hardware I
> bought. I might fail at some point .. but at least I can say I tried.

Yeap, good luck.  FYI, my seagate 7200.9 and samsung hd160jj work fine @ 
3Gbps on ICH7 AHCI, sil3124 and sil3132.

--
tejun



--------------030906020207000105050100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8beba3c..966be30 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1503,20 +1503,23 @@ void ata_port_probe(struct ata_port *ap)
  */
 static void sata_print_link_status(struct ata_port *ap)
 {
-	u32 sstatus, tmp;
+	u32 sstatus, scontrol, tmp;
 
 	if (!ap->ops->scr_read)
 		return;
 
 	sstatus = scr_read(ap, SCR_STATUS);
+	scontrol = scr_read(ap, SCR_CONTROL);
 
 	if (sata_dev_present(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		printk(KERN_INFO "ata%u: SATA link up %s (SStatus %X)\n",
-		       ap->id, sata_spd_string(tmp), sstatus);
+		printk(KERN_INFO
+		       "ata%u: SATA link up %s (SStatus %X SControl %X)\n",
+		       ap->id, sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
-		       ap->id, sstatus);
+		printk(KERN_INFO
+		       "ata%u: SATA link down (SStatus %X SControl %X)\n",
+		       ap->id, sstatus, scontrol);
 	}
 }
 

--------------030906020207000105050100--
