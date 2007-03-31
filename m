From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata bugfix: preserve LBA bit for HDIO_DRIVE_TASK
Date: Sat, 31 Mar 2007 12:36:05 +0900
Message-ID: <460DD725.1040607@gmail.com>
References: <20070330205938.984247529@mini.kroah.org> <20070330210659.GK29450@kroah.com> <460D8510.1050102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:57538 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXCaDgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Mar 2007 23:36:11 -0400
Received: by nz-out-0506.google.com with SMTP id s1so593037nze
        for <linux-ide@vger.kernel.org>; Fri, 30 Mar 2007 20:36:09 -0700 (PDT)
In-Reply-To: <460D8510.1050102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, IDE/ATA development list <linux-ide@vger.kernel.org>

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
> 
>     /* Good values for timeout and retries?  Values below

IDE seems to be just overriding devsel (0x10) and leaving the rest
alone.  Maybe we should do (args[6] & ~0x10) here?  Or is it safer this way?

Thanks.

-- 
tejun
