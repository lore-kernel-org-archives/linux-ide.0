From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: [PATCH 2.6.11.5 ] sata_sil: Fix FIFO PCI Bus Arbitration
Date: Wed, 23 Mar 2005 11:23:32 -0800
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D7F00@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from siimage.com ([12.24.47.101]:61705 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S262018AbVCWTWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2005 14:22:33 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Thanks to you Jeff.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Wednesday, March 23, 2005 11:13 AM
To: Carlos Pardo
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11.5 ] sata_sil: Fix FIFO PCI Bus Arbitration


Carlos Pardo wrote:
> This patch set default values for the FIFO PCI Bus Arbitration to avoid data corruption. The root cause is due to our PCI bus master handling mismatch with the chipset PCI bridge during DMA xfer (write data to the device). The patch is to setup the DMA fifo threshold so that there is no chance for the DMA engine to change protocol. We have seen this problem only on one motherboard.
> 
> Signed-off-by: Silicon Image Corporation <cpardo@siliconimage.com

Thanks, Carlos.

Patch looks good, I'll merge ASAP.

	Jeff



