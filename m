From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 01:48:02 -0500
Message-ID: <421D78A2.8090103@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D41C2.3030909@pobox.com> <421D663B.5050107@tw.ibm.com> <421D679B.7020508@pobox.com> <421D7727.4030408@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64665 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261871AbVBXGsQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 01:48:16 -0500
In-Reply-To: <421D7727.4030408@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Thanks for the detailed instruction.
> Attached please find the revised patch for your review.

Thanks for the updated patch.

Patch looks OK except:


> --- libata-dev-2.6/drivers/scsi/libata-scsi.c    2005-02-21 
> 17:23:03.000000000 +0800
> +++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c    2005-02-22 
> 18:32:19.000000000 +0800
> @@ -785,6 +785,7 @@
>          if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
>              return 1;
>         
> +        tf->command = ATA_CMD_VERIFY;
>          tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
>          tf->lbal = sect;
>          tf->lbam = cyl;
> @@ -875,7 +876,7 @@
> 
>      /* Check and compose ATA command */
>      if (!n_block)
> -        /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 
> sectors. */
> +        /* In ATA, sector count 0 means 256 or 65536 sectors, not 0 
> sectors. */

Please submit these libata-scsi changes in a separate patch.

	Jeff


