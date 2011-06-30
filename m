From: Tejun Heo <tj@kernel.org>
Subject: Re: Suppressing ATA errors on boot
Date: Thu, 30 Jun 2011 18:39:40 +0200
Message-ID: <20110630163940.GT3386@htj.dyndns.org>
References: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com>
 <20110630094937.GO3386@htj.dyndns.org>
 <438EE45C-A01E-4F77-8314-5DF9E8332E21@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57654 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab1F3Qjp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2011 12:39:45 -0400
Received: by bwd5 with SMTP id 5so1970424bwd.19
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2011 09:39:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <438EE45C-A01E-4F77-8314-5DF9E8332E21@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Shaw <dshaw@jabberwocky.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Jun 30, 2011 at 11:22:47AM -0400, David Shaw wrote:
> On Jun 30, 2011, at 5:49 AM, Tejun Heo wrote:
> 
> > Hello,
> > 
> > On Wed, Jun 29, 2011 at 11:07:11AM -0400, David Shaw wrote:
> >> Is there some way to tell libata that those ports shouldn't even be
> >> probed?  Alternately, is there a way to selectively prevent those
> >> messages from being logged (without affecting the logging for the
> >> rest of the boot)?  Or perhaps a third solution?
> > 
> > Can you attach the output of "lspci -nn" and full boot log?
> 
> Sure.
> 
> ata_piix 0000:00:1f.2: PCI INT C -> GSI 23 (level, low) -> IRQ 23
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: SATA max UDMA/133 cmd 0xe8e0 ctl 0xe8d0 bmdma 0xec00 irq 23
> ata2: SATA max UDMA/133 cmd 0xe8e8 ctl 0xe8d4 bmdma 0xec08 irq 23
> ata_piix 0000:00:1f.5: PCI INT D -> GSI 22 (level, low) -> IRQ 22
> ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
> scsi2 : ata_piix
> scsi3 : ata_piix
> ata3: SATA max UDMA/133 cmd 0xe8f0 ctl 0xe8d8 bmdma 0xec20 irq 22
> ata4: SATA max UDMA/133 cmd 0xe8f8 ctl 0xe8dc bmdma 0xec28 irq 22
...
> ata2.00: failed to resume link (SControl 0)
> ata4: failed to resume link (SControl 0)
> ata4: SATA link down (SStatus 4 SControl 0)
> ata1.01: failed to resume link (SControl 0)
> ata1.01: SATA link down (SStatus 0 SControl 0)
> ata2.01: failed to resume link (SControl 0)
> ata2.00: SATA link down (SStatus 0 SControl 0)
> ata2.01: SATA link down (SStatus 0 SControl 0)

Hmmm.... I don't think there's any easy way to suppress the above
messages; however, the reason why they get printed through is because
they're marked KERN_ERR, but it isn't necessarily an error condition
and we should be fine with KERN_WARNING.

Does the following make the issue go away?

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 736bee5..0044370 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3552,7 +3552,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 	} while ((scontrol & 0xf0f) != 0x300 && --tries);
 
 	if ((scontrol & 0xf0f) != 0x300) {
-		ata_link_printk(link, KERN_ERR,
+		ata_link_printk(link, KERN_WARNING,
 				"failed to resume link (SControl %X)\n",
 				scontrol);
 		return 0;

