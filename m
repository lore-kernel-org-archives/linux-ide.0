From: Mason <slash.tmp@free.fr>
Subject: sata_dwc_460ex driver
Date: Fri, 27 May 2016 16:54:14 +0200
Message-ID: <57485F96.8010001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:33616 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbcE0Oym (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2016 10:54:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mans Rullgard <mans@mansr.com>, Christian Lamparter <chunkeey@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <andy.gross@linaro.org>, Kishon Vijay Abraham <kishon@ti.com>, Sebastian Frias <sf84@laposte.net>

Hello everyone,

I'm working on a SoC which embeds an IP block from Synopsys labeled
Synopsys DesignWare Cores Serial ATA AHCI Core, aka DWC_ahsata
(DWC SATA AHCI Host 6Gb/s AXI Interface).

Would the sata_dwc_460ex driver support this DWC_ahsata hardware?

I suppose I would also need to enable AHCI support, right?

What is the difference between SATA_AHCI and SATA_AHCI_PLATFORM ?

SATA_AHCI          = 971db06e09231
SATA_AHCI_PLATFORM = 1c2a49f61785e

If I understand correctly, SATA_AHCI is for platforms with a PCI bus,
while SATA_AHCI_PLATFORM is for other platforms. I probably want the
latter then?

On the analog side, the SATA PHY is also made by Synopsys.
Do I need to enable a specific driver?
I didn't see anything relevant in drivers/phy

(The documentation mentions 11 registers for tweaking the controller,
but maybe it's the boot-loader's job to set this up correctly?)

Regards.
