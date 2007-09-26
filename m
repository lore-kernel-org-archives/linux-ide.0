From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Wed, 26 Sep 2007 10:33:28 -0400
Message-ID: <46FA6DB8.70508@garzik.org>
References: <200709211327569648280@gmail.com>	<46F9DA07.4080201@garzik.org>	<20070926122332.39351382@the-village.bc.nu>	<46FA4587.4070105@garzik.org> <20070926153028.6fc5b2ce@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762257AbXIZOds@vger.kernel.org>
In-Reply-To: <20070926153028.6fc5b2ce@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peer Chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>>> NAK - mmio is an iomap so writel and readl are the wrong things to use
>> The patch is consistent with the rest of the driver.
>> You are welcome to submit a patch to convert ahci to using ioremap.
> 
> You could just flip the relevant function to use ioread while you are
> tidying it up, instead of spreading new bugs into the code.

No, as I just noted above, the proper fix for this driver is to use 
ioremap rather than pci_iomap.

Adding support to ahci for legacy PIO is completely pointless.

	Jeff
