From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11.5 ] sata_sil: Fix FIFO PCI Bus Arbitration
Date: Wed, 23 Mar 2005 14:12:53 -0500
Message-ID: <4241BFB5.303@pobox.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D7EF5@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32998 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262784AbVCWTNJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2005 14:13:09 -0500
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B045D7EF5@zima.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: linux-ide@vger.kernel.org

Carlos Pardo wrote:
> This patch set default values for the FIFO PCI Bus Arbitration to avoid data corruption. The root cause is due to our PCI bus master handling mismatch with the chipset PCI bridge during DMA xfer (write data to the device). The patch is to setup the DMA fifo threshold so that there is no chance for the DMA engine to change protocol. We have seen this problem only on one motherboard.
> 
> Signed-off-by: Silicon Image Corporation <cpardo@siliconimage.com

Thanks, Carlos.

Patch looks good, I'll merge ASAP.

	Jeff



