From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Mounting CF flash card in 2.6.25
Date: Tue, 3 Jun 2008 17:19:23 +0100
Message-ID: <20080603171923.7aaf87b5@core>
References: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52124 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751925AbYFCQe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 12:34:27 -0400
In-Reply-To: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vb <vb@vsbe.com>
Cc: linux-ide@vger.kernel.org

> scsi0 : pata_platform
> ata1: PATA max PIO6 mmio cmd 0xfc000000 ctl 0xfc00020c irq 20
> ata1.00: CFA: CF 512MB, 06/07/29, max PIO4
> ata1.00: 1028160 sectors, multi 0: LBA
> ata1.00: configured for PIO
> ata1.00: configured for PIO
> ata1: EH complete
> scsi 0:0:0:0: Direct-Access     ATA      CF 512MB         06/0 PQ: 0 ANSI: 5
> 
> 
> which tells me that the card is being recognized. However, there is no
> appropriate device get created in the /dev directory. Examining

The /dev creation is up to your initrd.

> impression that the one in pata_of_platform is supposed to do for a
> generic CF card.

In your case it seems to be correct.

> What needs to be done to get the device created and mapped to  a
> generic CF card?

You need to ensure you have SCSI_DISK support included (as CF is a disk)
and you need your initrd either to create device nodes, or to prepack
them.
