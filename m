From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/14] libata-link: introduce ata_link
Date: Wed, 15 Aug 2007 03:00:34 -0400
Message-ID: <46C2A492.8040108@garzik.org>
References: <11863929824079-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53045 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbXHOHAg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 03:00:36 -0400
In-Reply-To: <11863929824079-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Introduce ata_link.  It abstracts PHY and sits between ata_port and
> ata_device.  This new level of abstraction is necessary to support
> SATA Port Multiplier, which basically adds a bunch of links (PHYs) to
> a ATA host port.  Fields related to command execution, spd_limit and
> EH are per-link and thus moved to ata_link.
> 
> This patch only defines the host link.  Multiple link handling will be
> added later.  Also, a lot of ap->link derefences are added but many of
> them will be removed as each part is converted to deal directly with
> ata_link instead of ata_port.
> 
> This patch introduces no behavior change.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: James Bottomley <James.Bottomley@SteelEye.com>
> ---
>  drivers/ata/ahci.c            |   18 +++---
>  drivers/ata/ata_generic.c     |    2 +-
>  drivers/ata/libata-acpi.c     |   21 +++---
>  drivers/ata/libata-core.c     |  157 ++++++++++++++++++++++-------------------
>  drivers/ata/libata-eh.c       |  100 +++++++++++++-------------
>  drivers/ata/libata-scsi.c     |   41 ++++++-----
>  drivers/ata/libata-sff.c      |    4 +-
>  drivers/ata/pata_it821x.c     |    4 +-
>  drivers/ata/pata_ixp4xx_cf.c  |    4 +-
>  drivers/ata/pata_legacy.c     |    4 +-
>  drivers/ata/pata_optidma.c    |    4 +-
>  drivers/ata/pata_pcmcia.c     |    4 +-
>  drivers/ata/pata_pdc2027x.c   |    2 +-
>  drivers/ata/pata_platform.c   |    2 +-
>  drivers/ata/pata_qdi.c        |    2 +-
>  drivers/ata/pata_rz1000.c     |    2 +-
>  drivers/ata/pata_scc.c        |    2 +-
>  drivers/ata/pata_sis.c        |    2 +-
>  drivers/ata/pata_winbond.c    |    2 +-
>  drivers/ata/pdc_adma.c        |    9 ++-
>  drivers/ata/sata_inic162x.c   |    7 +-
>  drivers/ata/sata_mv.c         |   14 ++--
>  drivers/ata/sata_nv.c         |   26 ++++----
>  drivers/ata/sata_promise.c    |    6 +-
>  drivers/ata/sata_qstor.c      |    4 +-
>  drivers/ata/sata_sil.c        |   14 ++--
>  drivers/ata/sata_sil24.c      |   14 ++--
>  drivers/ata/sata_sx4.c        |    4 +-
>  drivers/ata/sata_via.c        |    2 +-
>  drivers/ata/sata_vsc.c        |    2 +-
>  drivers/scsi/ipr.c            |    6 +-
>  drivers/scsi/libsas/sas_ata.c |   10 ++--
>  include/linux/libata.h        |   40 +++++++----
>  33 files changed, 280 insertions(+), 255 deletions(-)

applied 1-14 to #upstream


