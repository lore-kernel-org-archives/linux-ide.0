From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 29 Sep 2004 23:32:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415B7E64.50709@pobox.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>	 <415B34FC.8060908@pobox.com> <8746466a0409291532471417b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268648AbUI3DdI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 23:33:08 -0400
In-Reply-To: <8746466a0409291532471417b8@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Dave <dave.jiang@gmail.com>, jeremy.higdon@sgi.com
Cc: linux-ide@vger.kernel.org

Dave wrote:
> I believe waiting for you to comment on whether to put in a hook for
> controllers that do not support ATA_NIEN so it can mask/unmask IRQ
> with a fixup.  Even though the spec for this particular SATA
> controller says the bit is reserved, it seems to work just fine. From
> my understanding, the registers are actually on the drives, and the
> ones we write to the HBAs are just shadow registers right? I suppose
> either we can use the "undocumented" reserved bit for ATA_NIEN, or
> provide some sort of special hook in lib_ata core to clear the
> interrupt bit....


Close.

The shadow registers are an entity that exists solely on the host 
controller.  The entire register block is converted internally by the 
silicon to a SATA Host-to-Device Register FIS, and the FIS is what is 
sent to the SATA device.

As you can see in the SATA specification (www.serialata.org), each SATA 
FIS contains an interrupt bit.  The decision about when and how to set 
this interrupt bit is highly controller-specific.  Sometimes it is 
mapped to nIEN in the Device Control register.  Sometimes it is 
completely ignored (as with AHCI), and the controller sends interrupts 
based on various bits set in an interrupt-status register.

In any case, it is still not clear what you are trying to achieve :(

In what way is sata_vsc's current ATA_NIEN handling code deficient?

	Jeff


