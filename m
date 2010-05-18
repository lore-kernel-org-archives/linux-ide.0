From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/23] libata: kill ATA_FLAG_DISABLED
Date: Mon, 17 May 2010 22:49:46 -0400
Message-ID: <4BF2004A.7030609@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-7-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43109 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0ERCtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 22:49:51 -0400
Received: by gyg13 with SMTP id 13so2567975gyg.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 19:49:49 -0700 (PDT)
In-Reply-To: <1273520507-32459-7-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> ATA_FLAG_DISABLED is only used by drivers which don't use
> ->error_handler framework and is largely broken.  Its only meaningful
> function is to make irq handlers skip processing if the flag is set,
> which is largely useless and even harmful as it makes those ports more
> likely to cause IRQ storms.
>
> Kill ATA_FLAG_DISABLED and makes the callers disable attached devices
> instead.  ata_port_probe() and ata_port_disable() which manipulate the
> flag are also killed.
>
> This simplifies condition check in IRQ handlers.  While updating IRQ
> handlers, remove ap NULL check as libata guarantees consecutive port
> allocation (unoccupied ports are initialized with dummies) and
> long-obsolete ATA_QCFLAG_ACTIVE check (checked by ata_qc_from_tag()).
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-core.c           |   66 +----------
>   drivers/ata/libata-scsi.c           |    3 -
>   drivers/ata/libata-sff.c            |   10 +--
>   drivers/ata/pata_bf54x.c            |   16 +--
>   drivers/ata/pata_octeon_cf.c        |    9 +-
>   drivers/ata/pdc_adma.c              |   66 +++++------
>   drivers/ata/sata_inic162x.c         |   17 +--
>   drivers/ata/sata_mv.c               |   18 +--
>   drivers/ata/sata_nv.c               |  238 +++++++++++++++++------------------
>   drivers/ata/sata_promise.c          |    6 +-
>   drivers/ata/sata_qstor.c            |   79 ++++++------
>   drivers/ata/sata_sil.c              |    3 -
>   drivers/ata/sata_sil24.c            |    9 +-
>   drivers/ata/sata_sx4.c              |    3 +-
>   drivers/ata/sata_vsc.c              |   10 +--
>   drivers/scsi/ipr.c                  |    6 +-
>   drivers/scsi/libsas/sas_scsi_host.c |    2 +-
>   include/linux/libata.h              |    8 --
>   18 files changed, 210 insertions(+), 359 deletions(-)

applied 6-8


