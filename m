From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Assorted bugs in the PIIX drivers
Date: Fri, 25 Nov 2005 14:43:28 +0000
Message-ID: <1132929808.3298.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:12504 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161087AbVKYOKc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Nov 2005 09:10:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I finally got all the documents rounded up to try and redo Jgarzik's
PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)

I then started reading the docs and the code and noticing a couple of
problems

1.	We set IE1 on PIO0-2 which the docs say is for PIO3+

2.	The ata_piix one (but not the ide/pci one) have shifts wrong so that
the secondary slave timings are half loaded into the primary slave


I'm also not clear if the "no MWDMA0" list has been updated correctly
for the newer chipsets.

I've yet to review the DMA programming, just the PIO so far.

