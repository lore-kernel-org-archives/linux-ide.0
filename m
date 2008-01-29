From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.24] ata_piix:  IDE mode SATA patch for Intel ICH10
 DeviceID's
Date: Tue, 29 Jan 2008 12:14:07 -0500
Message-ID: <479F5EDF.9010601@pobox.com>
References: <200801281736.45574.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35030 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760172AbYA2ROJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 12:14:09 -0500
In-Reply-To: <200801281736.45574.jason.d.gaston@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

Jason Gaston wrote:
> This patch adds the Intel ICH10 IDE mode SATA Controller DeviceID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.24/drivers/ata/ata_piix.c.orig	2008-01-24 14:58:37.000000000 -0800
> +++ linux-2.6.24/drivers/ata/ata_piix.c	2008-01-28 14:58:22.000000000 -0800
> @@ -263,6 +263,14 @@
>  	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>  	/* SATA Controller IDE (Tolapai) */
>  	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata_ahci },
> +	/* SATA Controller IDE (ICH10) */
> +	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	/* SATA Controller IDE (ICH10) */
> +	{ 0x8086, 0x3a06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (ICH10) */
> +	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	/* SATA Controller IDE (ICH10) */
> +	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },

can these do AHCI mode without losing any PATA ports?

if so, I would prefer to always drive the hardware in AHCI mode, if it 
is capable of doing so.

