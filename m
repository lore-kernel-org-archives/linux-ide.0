From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/12] libata: return AC_ERR_* from issue functions
Date: Sun, 22 Jan 2006 04:36:31 -0500
Message-ID: <43D3521F.2050702@pobox.com>
References: <11379167103159-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17638 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932261AbWAVJgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:36:38 -0500
In-Reply-To: <11379167103159-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Return AC_ERR_* mask from issue fuctions instead of 0/-1.  This
> enables things like failing a qc with AC_ERR_HSM when the device
> doesn't set DRDY when the qc is about to be issued.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ahci.c         |    4 ++--
>  drivers/scsi/libata-core.c  |   17 ++++++++---------
>  drivers/scsi/libata-scsi.c  |   10 ++++------
>  drivers/scsi/libata.h       |    2 +-
>  drivers/scsi/pdc_adma.c     |    4 ++--
>  drivers/scsi/sata_mv.c      |    4 ++--
>  drivers/scsi/sata_promise.c |    4 ++--
>  drivers/scsi/sata_qstor.c   |    4 ++--
>  drivers/scsi/sata_sil24.c   |    4 ++--
>  drivers/scsi/sata_sx4.c     |    4 ++--
>  include/linux/libata.h      |    4 ++--
>  11 files changed, 29 insertions(+), 32 deletions(-)

OK, except, this makes me wonder if an ata_err_t type is needed.

	Jeff


