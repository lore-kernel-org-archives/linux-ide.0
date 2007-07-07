From: Jeff Garzik <jeff@garzik.org>
Subject: libata-dev.git clean up and branch status
Date: Fri, 06 Jul 2007 20:21:10 -0400
Message-ID: <468EDC76.9050708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754484AbXGGAVZ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

libata-dev.git was left a bit grotty when I went on vacation.  That has 
now been fixed.  The current branches are:

git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

master		Always vanilla Linus tree

ALL		Always the "exported for testing" meta-branch
		(currently == upstream + sil680-mmio + mv-ahci)

upstream	queued for 2.6.23
		Parent: master

mv-ahci		Marvell 6121/6141 AHCI clone SATA support
		Parent: upstream
		Status: Works, once NCQ & PCI MSI are disabled.
			Turn these off, then can go up.

mv-ahci-pata	Marvell 6121/6141 AHCI clone PATA support
		Parent: mv-ahci
		Status: Need to update for proper use of PATA
			controller commands (provides direct access to
			PATA device shadow registers)

mv-eh		sata_mv (50xx/60xx) conversion to new EH
		Parent: upstream
		Status: Required for hotplug, NCQ, etc.  Working, but
			currently NCQ disks fail (even if NCQ not used)

new-eh		pdc_adma, sata_qstor, sata_sx4 conversion to new EH
		Parent: upstream
		Status: All conversions complete...
			and completely untested.

sii-lbt		sata_sil Large [DMA] Block Transfer support
		Parent: upstream
		Status: Useful, but reported to fail in some cases

sil680-mmio	pata_sil680 MMIO support
		Parent: upstream
		Status: dissolved into some argument about MMIO flushing
