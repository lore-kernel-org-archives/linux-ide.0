From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream 1/3] libata: use ata_port_printk()
 in ata_wait_idle()
Date: Wed, 15 Aug 2007 04:49:20 -0400
Message-ID: <46C2BE10.7040401@garzik.org>
References: <20070730052303.GH22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51837 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbXHOItW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:49:22 -0400
In-Reply-To: <20070730052303.GH22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_wait_idle() identified controller by printing out the address of
> the Status register.  This is bogus because 1. it's iomapped address
> 2. some controllers don't have Status register and don't initialize
> the field.  Use ata_port_printk() instead.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Currently there's no equivalent ata_msg_* level for ATA_DEBUG, so the
> printk is conditionalized with #ifdef ATA_DEBUG.  We need to kill
> ATA_DEBUG, ATA_VERBOSE_DEBUG and integrate them into ata_msg_* in the
> future.
> 
>  include/linux/libata.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

applied 1-2 of 3


