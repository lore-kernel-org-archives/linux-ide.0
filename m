From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Mon, 4 Dec 2006 12:56:37 +0000
Message-ID: <20061204125637.539c102d@localhost.localdomain>
References: <200612031834.16797.sven@linux4geeks.de>
	<45735B51.5040501@gmx.net>
	<20061204001114.066b10f3@localhost.localdomain>
	<457370CB.60008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:3533 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936351AbWLDMuz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 07:50:55 -0500
In-Reply-To: <457370CB.60008@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org

On Mon, 04 Dec 2006 01:50:19 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> One port is PATA, the other port is SATA, they have the same PCI
> resources. It is possible to configure
> the controller to use both ports in SATA mode without slave. Then the
> PATA part of the controller is not
> reachable.

Ok so if the pata_sis driver exports

	sis_info133		(UDMA 133 port_info structure)

is that sufficient for you to attach the PATA port to the PATA methods
for this chipset ?

Alan
