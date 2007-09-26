From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] libata: misc updates for AN
Date: Tue, 25 Sep 2007 22:27:04 -0400
Message-ID: <46F9C378.5080203@garzik.org>
References: <11905208512312-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52198 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbXIZC1H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:27:07 -0400
In-Reply-To: <11905208512312-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Update AN support in preparation of PMP support.
> 
> * s/ata_id_has_AN/ata_id_has_atapi_AN/
> * add AN enabled reporting during configuration
> * add err_mask to AN configuration failure reporting
> * update LOCKING comment for ata_scsi_media_change_notify()
> * check whether ATA dev is attached to SCSI dev ata_scsi_media_change_notify()
> * set ATA_FLAG_AN in ahci and sata_sil24
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Kriten Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/ata/ahci.c        |    2 +-
>  drivers/ata/libata-core.c |   24 ++++++++++++++----------
>  drivers/ata/libata-scsi.c |    7 ++++---
>  drivers/ata/sata_sil24.c  |   13 +++++++++++--
>  include/linux/ata.h       |    2 +-
>  5 files changed, 31 insertions(+), 17 deletions(-)

applied 1-12


