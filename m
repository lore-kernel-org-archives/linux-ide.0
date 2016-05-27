From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: sata_dwc_460ex driver
Date: Fri, 27 May 2016 17:20:31 +0100
Message-ID: <yw1xeg8n5v74.fsf@unicorn.mansr.com>
References: <57485F96.8010001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:44627 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080AbcE0QUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2016 12:20:37 -0400
In-Reply-To: <57485F96.8010001@free.fr> (Mason's message of "Fri, 27 May 2016
	16:54:14 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Lamparter <chunkeey@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <andy.gross@linaro.org>, Kishon Vijay Abraham <kishon@ti.com>, Sebastian Frias <sf84@laposte.net>

Mason <slash.tmp@free.fr> writes:

> Hello everyone,
>
> I'm working on a SoC which embeds an IP block from Synopsys labeled
> Synopsys DesignWare Cores Serial ATA AHCI Core, aka DWC_ahsata
> (DWC SATA AHCI Host 6Gb/s AXI Interface).
>
> Would the sata_dwc_460ex driver support this DWC_ahsata hardware?
>
> I suppose I would also need to enable AHCI support, right?
>
> What is the difference between SATA_AHCI and SATA_AHCI_PLATFORM ?
>
> SATA_AHCI          =3D 971db06e09231
> SATA_AHCI_PLATFORM =3D 1c2a49f61785e
>
> If I understand correctly, SATA_AHCI is for platforms with a PCI bus,
> while SATA_AHCI_PLATFORM is for other platforms. I probably want the
> latter then?
>
> On the analog side, the SATA PHY is also made by Synopsys.
> Do I need to enable a specific driver?
> I didn't see anything relevant in drivers/phy
>
> (The documentation mentions 11 registers for tweaking the controller,
> but maybe it's the boot-loader's job to set this up correctly?)

The sata_dwc_460ex driver can be made to work with the tango3/4 chips.
You need a dmaengine driver (I've written one for tango3, needs slight
tweaking for tango4) and some additions to the SATA driver to handle th=
e
DMA glue logic (I have unpublished code for this as well).  There are a
bunch of fixes for the SATA driver currently in linux-next, and I was
planning to take another look at supporting tango3/4 once these hit
mainline (4.7-rc1 most likely).

A driver for the PHY is probably a good idea, even if the boot loader
does some configuration, since this allows it to be powered down when
not in use.

--=20
M=E5ns Rullg=E5rd
