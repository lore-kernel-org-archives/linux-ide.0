From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363  (JMB363) kernel 2.6.25-2 Debian/Lenny
Date: Wed, 17 Sep 2008 17:31:07 +0200
Message-ID: <m33ajyx004.fsf@maximus.localdomain>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org>
	<g8q9mg$v2p$1@ger.gmane.org> <48B0E608.4050205@garzik.org>
	<g8sqp1$jn4$1@ger.gmane.org> <ug87q5-llh.ln1@legba.gamic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:55830 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbYIQPbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 11:31:09 -0400
In-Reply-To: <ug87q5-llh.ln1@legba.gamic.com> (Sergey Spiridonov's message of "Wed\, 17 Sep 2008 14\:07\:26 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Spiridonov <sena@hurd.homeunix.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Sergey Spiridonov <sena@hurd.homeunix.org> writes:

> I got a replacement motherboard. And I got absolutely same errors and
> problems.

FWIW I have an MSI (P45 Neo2) mobo with JMB363 (only PATA connected)
and its second AHCI port (ata8, not connected) gives me the following.

The 2.6.26.2 kernel doesn't see any problem:

Linux version 2.6.26.2 (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) SMP
ata7: SATA max UDMA/133 abar m8192@0xfeafe000 port 0xfeafe100 irq 16
ata8: SATA max UDMA/133 abar m8192@0xfeafe000 port 0xfeafe180 irq 16
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata9: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 17
ata10: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 17
ata9.00: ATAPI: _NEC DVD_RW ND-4550A, 1.09, max UDMA/33
ata9.00: configured for UDMA/33

Now with 2.6.26.3:
ata7: SATA max UDMA/133 abar m8192@0xfeafe000 port 0xfeafe100 irq 16
ata8: SATA max UDMA/133 abar m8192@0xfeafe000 port 0xfeafe180 irq 16
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata9: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 17
ata10: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 17
ata9.00: ATAPI: _NEC DVD_RW ND-4550A, 1.09, max UDMA/33
ata9.00: configured for UDMA/33
ata8: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
ata8: irq_stat 0x00000040, connection status changed
ata8: SError: { DevExch }
ata8: hard resetting link
ata8: SATA link down (SStatus 0 SControl 300)
ata8: EH complete
ata8: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
ata8: irq_stat 0x00000040, connection status changed
ata8: SError: { DevExch }
ata8: hard resetting link
ata8: SATA link down (SStatus 0 SControl 300)
ata8: EH complete
ata8: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
ata8: irq_stat 0x00000040, connection status changed
ata8: SError: { DevExch }
ata8: hard resetting link
...

.config differences which could somehow be relevant(?):

-CONFIG_GART_IOMMU=y
-CONFIG_K8_NB=y
-CONFIG_AGP_AMD64=y

(I'm using SWIOTLB in both cases, it's P45/Core2 duo based machine).

Can't see anything between 2.6.26.2 and 2.6.26.3 which could cause
that. Perhaps I should bisect it anyway?
For now I have just disabled these AHCI devices, didn't know that it
was ok with 2.6.26.2 (just noticed it in the logs). Will look at it.
-- 
Krzysztof Halasa
