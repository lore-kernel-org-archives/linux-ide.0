From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata bugfix: preserve LBA bit for HDIO_DRIVE_TASK
Date: Wed, 04 Apr 2007 02:08:37 -0400
Message-ID: <461340E5.2070901@garzik.org>
References: <20070330205938.984247529@mini.kroah.org> <20070330210659.GK29450@kroah.com> <460D8510.1050102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41631 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992680AbXDDGIu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 02:08:50 -0400
In-Reply-To: <460D8510.1050102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Ideally, this would go into linux-2.6.21.
> 
> Preserve the LBA bit in the DevSel/Head register for HDIO_DRIVE_TASK.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> --- linux/drivers/ata/libata-scsi.c.orig    2007-03-21 
> 13:35:02.000000000 -0400
> +++ linux/drivers/ata/libata-scsi.c    2007-03-30 17:40:58.000000000 -0400
> @@ -333,7 +333,7 @@
>     scsi_cmd[8]  = args[3];
>     scsi_cmd[10] = args[4];
>     scsi_cmd[12] = args[5];
> -    scsi_cmd[13] = args[6] & 0x0f;
> +    scsi_cmd[13] = args[6] & 0x4f;
>     scsi_cmd[14] = args[0];

applied


