From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata, Add " 2GB ATA Flash Disk"/"ADMA428M" to DMA blacklist
Date: Tue, 22 May 2012 16:04:49 -0400
Message-ID: <4FBBF161.70006@pobox.com>
References: <1336482482-3200-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40580 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337Ab2EVUEw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 May 2012 16:04:52 -0400
Received: by qadb17 with SMTP id b17so2627181qad.19
        for <linux-ide@vger.kernel.org>; Tue, 22 May 2012 13:04:51 -0700 (PDT)
In-Reply-To: <1336482482-3200-1-git-send-email-prarit@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-ide@vger.kernel.org

On 05/08/2012 09:08 AM, Prarit Bhargava wrote:
> A user has several systems with a couple of models of flash disks with IDE
> connectors.  These disks work fine in 2.6.18-ish kernels but corrupt data on
> new kernels.
>
> The difference appears to be with the default I/O method used by the IDE
> controller driver between the kernels.  In the older kernels, the
> configuration is very conservative and the driver stays in PIO mode.  With
> new kernels, the ata driver (pata_serverworks) attempts to use UDMA/66
> which the drive claims to support.  This mode, however, does not appear to
> work in DMA mode.  The drive does work correctly and no corruption is
> seen if the kernel parameter "libata.force=5:pio0,6:pio0" is used to force
> the driver to use PIO instead of DMA mode.
>
> Blacklist these drives.  Unfortunately the model name of the drive is very
> generic, " 2GB ATA Flash Disk", but the revision is specific, "ADMA428M".
>
> Signed-off-by: Prarit Bhargava<prarit@redhat.com>
> Cc: Jeff Garzik<jgarzik@pobox.com>
> ---
>   drivers/ata/libata-core.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

applied



