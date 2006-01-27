From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Thu, 26 Jan 2006 21:57:39 -0500
Message-ID: <43D98C23.4040004@pobox.com>
References: <20051218081707.GA4129@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:38585 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030260AbWA0C5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 21:57:44 -0500
In-Reply-To: <20051218081707.GA4129@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Unlike their older siblings, ICH6 and 7 use different scheme for MAP
> VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.
> 
> Pre-ICH6/7
> 
>  The value of these bits indicate the address range the SATA port
>  responds to, and whether or not the SATA and IDE functions are
>  combined.
> 
>  000 = Non-combined. P0 is primary master. P1 is secondary master.
>  001 = Non-combined. P0 is secondary master. P1 is primary master.
>  100 = Combined. P0 is primary master. P1 is primary slave. P-ATA is
>        2:0 Map Value secondary.
>  101 = Combined. P0 is primary slave. P1 is primary master. P-ATA is
>        secondary.
>  110 = Combined. P-ATA is primary. P0 is secondary master. P1 is
>        secondary slave.
>  111 = Combined. P-ATA is primary. P0 is secondary slave. P1 is
>        secondary master.
> 
> ICH6/7
> 
>  Map Value - R/W. Map Value (MV): The value in the bits below indicate
> the address range the SATA ports responds to, and whether or not the
> PATA and SATA functions are combined. When in combined mode, the AHCI
> memory space is not available and AHCI may not be used.
> 
>  00 = Non-combined. P0 is primary master, P2 is the primary slave. P1
>       is secondary master, P3 is the 1:0 secondary slave (desktop
>       only). P0 is primary master, P2 is the primary slave (mobile
>       only).
>  01 = Combined. IDE is primary. P1 is secondary master, P3 is the
>       secondary slave. (desktop only)
>  10 = Combined. P0 is primary master. P2 is primary slave. IDE is secondary
>  11 = Reserved
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to upstream-2.6.17.  patch looks OK, but only testing on 
ICH5+6+7 will really convince me.  Documentation has often been confused 
before, and the only data I've received from you is "it works for me." 
So, proceeding with caution :)

	Jeff



