From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Tue, 22 Jun 2004 23:51:49 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D8FE55.3030008@pobox.com>
References: <40D89509.6010502@pobox.com> <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org> <40D8FB8A.8040109@pobox.com> <Pine.LNX.4.60.0406230442410.2702@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265033AbUFWDwC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 23:52:02 -0400
In-Reply-To: <Pine.LNX.4.60.0406230442410.2702@fogarty.jakma.org>
List-Id: linux-ide@vger.kernel.org
To: Paul Jakma <paul@clubi.ie>
Cc: linux-ide@vger.kernel.org, Ricky Beam <jfbeam@bluetronic.net>, Linux Kernel <linux-kernel@vger.kernel.org>

Paul Jakma wrote:
> On Tue, 22 Jun 2004, Jeff Garzik wrote:
> 
>> Cool.  Yeah, non-Seagate should be full speed and unaffected...
> 
> 
> But I got the impression your patch enables mod15-quirk for all LBA48 
> drives, is that correct? If so, if I have to update kernels here, I 
> think I'll reverse that one if it affects all LBA48, as I'd rather not 
> suffer the performance hit (its slow enough already because of slow 
> CPU/chipset/contended PCI bus thank you very much ;) ) - until such time 
> as a better fix is known.


Nope, my patch only enables ATA_DFLAG_LOCK_SECTORS for devices flagged 
with SIL_QUIRK_MOD15WRITE:

         { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
         { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
         { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
         { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
         { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
         { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
         { "ST340014ASL",        SIL_QUIRK_MOD15WRITE },
         { "ST360014ASL",        SIL_QUIRK_MOD15WRITE },
         { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
         { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
         { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
         { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
[...]
         if (quirks & SIL_QUIRK_MOD15WRITE) {
                 printk(KERN_INFO "ata%u(%u): applying errata fix\n",
                        ap->id, dev->devno);
                 ap->host->max_sectors = 15;
                 ap->host->hostt->max_sectors = 15;
                 dev->flags |= ATA_DFLAG_LOCK_SECTORS;
                 return;
         }
