From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] Prevent interface errors with Seagate FreeAgent GoFlex
Date: Thu, 03 May 2012 23:23:14 +0200
Message-ID: <4FA2F742.9010000@fold.natur.cuni.cz>
References: <1336058460-19924-1-git-send-email-daniel@quora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:40445 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756549Ab2ECVXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2012 17:23:17 -0400
In-Reply-To: <1336058460-19924-1-git-send-email-daniel@quora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel@quora.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel J Blueman wrote:
> When connected by the optional eSATAp cable, various interface errors
> occur with my new external Seagate FreeAgent GoFlex (firmware 0110) until
> the interface is forced to 1.5Gbps mode. Blacklist 3.0Gbps mode with it
> to avoid the error messages, delays and dataloss potential.
> 
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 28db50b..0781510 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4119,6 +4119,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  
>  	/* Devices which aren't very happy with higher link speeds */
>  	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
> +	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_HORKAGE_1_5_GBPS, },
>  
>  	/*
>  	 * Devices which choke on SETXFER.  Applies only if both the



Hi,
  maybe I am talking nonsense but recently there were some fixes to bus speed posted here at
linux-ide list from Lin Ming <ming.m.lin@intel.com>.

In 3.4-rc5 it is already fixed so that if you unplug and re-plug a SATA disk it can be detected
at 3.0Gbps instead of just 1.5 (because previous unplug caused errors). An additional patch
"Subject: [PATCH v2] libata: skip old error history when counting probe trials"
was just applied few hours ago some maybe you want to re-test? So is your blacklisting necessary?

When inspecting my "lspci -vvvxx" outputs I see that lots of my chipset devices in my SandyBridge
laptop lifted up with the above mentioned patch from 2.5Gbps to 5Gbps
(was about in a thread "Re: Hotplug borked after suspend/resume in Linux-3.3 ?") which did not
original tackle the error counter issue which broke the re-plugging.

Probably ask Lin Ming directly as he wrote all the patches, or lookup linux-ide archives.
Hope this helps,
Martin
(I still do see problems with 3.4-rc5 on ExpressCard housed sata_sil24 so that unplug of a disk
and its re-plug results still only in 1.5Gbps instead of 3.0 Gbps, but if one waits a while
so that the SCSI device is removed, then a re-plug catches up at 3 Gbps. Probably have to apply
the patch to null the error counter. ;-))
