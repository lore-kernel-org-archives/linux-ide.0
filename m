From: Mark Lord <liml@rtr.ca>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive
 on QNAP TS-109
Date: Sat, 24 Jan 2009 09:57:36 -0500
Message-ID: <497B2C60.60608@rtr.ca>
References: <200808261124.39282.elendil@planet.nl> <200808261225.46315.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58863 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbZAXO5k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 09:57:40 -0500
In-Reply-To: <200808261225.46315.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> On Tuesday 26 August 2008, Frans Pop wrote:
>> After booting the system I did 'echo 1 >/sys/block/sdX/device/queue_depth'
>> and after that the HDD led showed disk activity again.
> 
> And to confirm that, applying the following patch to sata_mv for 2.6.26.3
> makes the HDD led work again as well:
> 
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
..
>                                   ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
> -                                 ATA_FLAG_NCQ | ATA_FLAG_AN,
> +                                 ATA_FLAG_AN,
..
> So somehow enabling NCQ is at the root of the issue.
..

Pardon me digging up this old thread again,
but I'm back working on sata_mv now.

There is a reported chipset errata for *exactly* this symptom,
though the errata is supposedly for the older 6041/6081 variants.
But it is possible that the same problem still exists in the
chip you are using there (SOC, right?).

The problem is exactly as you described it:  turning on NCQ
causes the activity LEDs to remain on constantly.
No known workaround or fix is available from Marvell,
so "just live with it" is the only solution.  :)

Cheers

