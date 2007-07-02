From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc4]: libata: PATA-mode fixes for sis_sata
Date: Mon, 02 Jul 2007 10:20:11 -0400
Message-ID: <4689099B.2060409@garzik.org>
References: <200706142340.44068.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXGBOUQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:20:16 -0400
In-Reply-To: <200706142340.44068.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, yulin@starsoftcomm.com, micha.biermann@gmx.de

Uwe Koziolek wrote:
> Changed PATA handler for PATA-ports used by sata_sis.
> This patch was originally submitted by Jeff Garzik.
> 
> Added PCI-ID 1180 for SiS966 Controller in pata_sis.
> The 1180 mode is fully compatible to other SiS PATA-controller.
> 
> The PCI-ID 1183 is SATA in PATA-emulation, but not fully compatible
> to SiS5513/5518. sata_sis.c is forwarding this ID to pata_sis.
> 1183 is not working if simply added to pata_sis.
> This handling fixes issues with SiS968.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

applied


