From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: kill NULL qc handling from ->eng_timeout
 callbacks
Date: Thu, 09 Feb 2006 01:33:47 -0500
Message-ID: <43EAE24B.4080909@pobox.com>
References: <11388093701071-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:23193 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422820AbWBIGdu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:33:50 -0500
In-Reply-To: <11388093701071-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> ->eng_timeout is not invoked with NULL qc anymore.  Kill NULL qc
> handling from all ->eng_timeout callbacks.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ahci.c         |   12 +++---------
>  drivers/scsi/libata-core.c  |   12 +-----------
>  drivers/scsi/sata_mv.c      |    9 ++-------
>  drivers/scsi/sata_promise.c |    9 +--------
>  drivers/scsi/sata_sil24.c   |    5 -----
>  drivers/scsi/sata_sx4.c     |    9 +--------
>  6 files changed, 8 insertions(+), 48 deletions(-)

ACK, but depends on NAK'd #3 of course


