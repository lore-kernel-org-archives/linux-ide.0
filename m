From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Thu, 03 Dec 2009 03:12:00 -0500
Message-ID: <4B1772D0.5030303@garzik.org>
References: <20091202003630.29919100851@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39669 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZLCILz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 03:11:55 -0500
Received: by yxe17 with SMTP id 17so941552yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 03 Dec 2009 00:12:02 -0800 (PST)
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, tj@kernel.org

On 12/01/2009 07:36 PM, Benjamin Herrenschmidt wrote:
> This is a libata driver for the "macio" IDE controller used on most Apple
> PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
>
> It supports all the features of its predecessor, including mediabay hotplug
> and suspend/resume. It should also support module load/unload.
>
> The timing calculations have been simplified to use pre-calculated tables
> compared to drivers/ide/pmac.c and it uses the new mediabay interface
> provided by a previous patch.
>
> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>
> v2. Better tested now, seems to be reasonably solid.
>
> Addressed Tejun comments and made remove more robust vs. media-bay,
> should also fix Andreas problem.
>
>
>   drivers/ata/Kconfig      |   10
>   drivers/ata/Makefile     |    1
>   drivers/ata/pata_macio.c | 1427 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1438 insertions(+)

Looks fine to me.  Two minor comments, which might perhaps be ignored if 
that is your taste:

* prefer enums to #define's, for constants

* prefer direct function call to "ap->ops->foo_bar()", because 
ap->ops->foo_bar() is guaranteed to be a constant value known to the 
driver.  The driver is the entity responsible for the function pointer.

Maybe saves a cycle or two.  Not terribly important, but hey, calling 
ap->ops->sff_exec_command() from pata_macio_bmdma_setup() is a hot path.

	Jeff





