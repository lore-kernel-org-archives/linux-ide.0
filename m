From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11.5 ] sata_sil: Fix FIFO PCI Bus Arbitration
Date: Thu, 24 Mar 2005 23:39:49 -0500
Message-ID: <42439615.8000605@pobox.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D7EF5@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36254 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261215AbVCYEkC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Mar 2005 23:40:02 -0500
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B045D7EF5@zima.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: linux-ide@vger.kernel.org

Carlos Pardo wrote:
> This patch set default values for the FIFO PCI Bus Arbitration to avoid data corruption. The root cause is due to our PCI bus master handling mismatch with the chipset PCI bridge during DMA xfer (write data to the device). The patch is to setup the DMA fifo threshold so that there is no chance for the DMA engine to change protocol. We have seen this problem only on one motherboard.
> 
> Signed-off-by: Silicon Image Corporation <cpardo@siliconimage.com

Patch applied to libata-2.4 and libata-2.6 queues, and will be sent 
upstream ASAP.  Thanks.

One slight problem with your submission:  your mailer encoded the 
plaintext patch using base64 encoding, which makes the patch difficult 
to review.

The preferred method of submitting patches is pasting them inline. 
However many Windows mailers will corrupt the whitespace in the patch, 
or wrap long lines, if you do this.

On Unix, the best way to accomplish this is described at

	http://lkml.org/lkml/2005/2/24/3

On Windows, the free (open source) Mozilla Thunderbird or Mozilla Mail 
applications should correctly attach plaintext patches without encoding 
them.

Regards,

	Jeff


