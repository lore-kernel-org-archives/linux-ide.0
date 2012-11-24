From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Is FBS (FIS) working on Silicon Image 3726 port multiplier?
Date: Sat, 24 Nov 2012 10:01:11 +0900
Message-ID: <AED0AC29B70A44EA8DD19C569B87263C@diamond1720>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp505.mail.kks.yahoo.co.jp ([114.111.99.166]:35580 "HELO
	smtp505.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932477Ab2KXBIQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2012 20:08:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wrot on October 17, 2012 2:25 PM

> I'm trying to use an SIL3726 with 5 SATA drives and an SIL3132.
> FBS should work, right?  But performance looks like CBS.
> Is there some way to check if FBS is actually enabled?

I added some ata_dev_printk calls in file libahci.c,
static void ahci_enable_fbs(struct ata_port *ap)
and a few other places, but none of them were logged.
In file libata-pmp.c, the following continues to be logged:
if (print_info) {
ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
       "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
       sata_pmp_spec_rev_str(gscr), vendor, devid,
       sata_pmp_gscr_rev(gscr),
       nr_ports, gscr[SATA_PMP_GSCR_FEAT_EN],
       gscr[SATA_PMP_GSCR_FEAT]);
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9

Finally I figured out that the sil24 driver uses its own port multiplier 
code and never calls the libahci code.

So the reason why it performs like CBS instead of FBS is due to something in 
the sil24 driver, or the SIL3132 HBA firmware, or the SIL3726 port 
multiplier firmware.  I still can't figure out which.

I read that someone else got FBS working on a Marvell HBA with SIL3726 port 
multiplier, but my Marvell HBA errors out in trying to detect the SIL3726, 
maybe because SAS-to-eSATA cables seem to have numerous problems.  My 
Marvell HBA also errors out trying to detect a JMicron port multiplier, 
maybe because of the same cable or maybe because JMicron firmware is 
generally pretty miserable.

Does anyone have FBS (FIS) working with an SIL3726? 

