From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] ata_scsi_verify_xlat() fix
Date: Thu, 24 Feb 2005 02:44:02 -0500
Message-ID: <421D85C2.6050103@pobox.com>
References: <421D7E5A.80702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25512 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261890AbVBXHoW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 02:44:22 -0500
In-Reply-To: <421D7E5A.80702@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
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
>          return 1;
> 


Patch looks OK, but does not appear to be diff'd against

	linux-2.6.11-rc4 + CHS support patches

When I try to apply your patch, I get

drivers/scsi/libata-scsi.c 1.68: 1661 lines
drivers/scsi/libata-scsi.c 1.68 -> 1.69: 1661 lines
2 out of 2 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-scsi.c.rej

When I examine your patch, I see that the line numbers are _way_ off:

my code line #622:
        /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sector

your patch attempts to modify line #875 !!

> @@ -875,7 +876,7 @@
> 
>         /* Check and compose ATA command */
>         if (!n_block)
> -               /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sector
> s. */
> +               /* In ATA, sector count 0 means 256 or 65536 sectors, not 0 sect

