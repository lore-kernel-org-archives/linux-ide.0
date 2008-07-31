From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] pata_via.c: add flag for VX800 and add a function
 for fixing internal bugs for VIA chipsets
Date: Thu, 31 Jul 2008 01:40:32 -0400
Message-ID: <48915050.5080003@garzik.org>
References: <200807301932.m6UJWmel012137@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44882 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbYGaFkh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:40:37 -0400
In-Reply-To: <200807301932.m6UJWmel012137@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, JosephChan@via.com.tw, alan@lxorguk.ukuu.org.uk, tj@kernel.org

akpm@linux-foundation.org wrote:
> From: <JosephChan@via.com.tw>
> 
> Add flag VIA_SATA_PATA for vx800, VX800 uses the same
> chipset(0x0581/0x5324) as CX700, which has 1 PATA channel(Master/Slave)
> and 1 SATA channel(Master/Slave) Add function <via_ata_tf_load>.  This is
> to fix the internal bug of VIA chipsets, which will reset the device
> register after changing the IEN bit in CTL register
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_via.c |   64 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)

applied


