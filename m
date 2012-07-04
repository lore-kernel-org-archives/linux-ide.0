From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: implement MODE SELECT command
Date: Wed, 04 Jul 2012 21:08:45 +0400
Message-ID: <4FF4789D.508@mvista.com>
References: <1341400436-2546-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61860 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2GDRKM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2012 13:10:12 -0400
Received: by lbbgm6 with SMTP id gm6so11470411lbb.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2012 10:10:11 -0700 (PDT)
In-Reply-To: <1341400436-2546-1-git-send-email-pbonzini@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello.

On 07/04/2012 03:13 PM, Paolo Bonzini wrote:

> The cache_type file in sysfs lets users configure the disk cache in
> write-through or write-back modes.  However, ata disks do not support
> writing to the file because they do not implement the MODE SELECT
> command.

> This patch adds a translation from MODE SELECT (for the caching page
> only) to the ATA SET FEATURES command.

> Cc: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  drivers/ata/libata-scsi.c |  147 +++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 142 insertions(+), 5 deletions(-)

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 41cde45..e7702d3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[...]
> +	switch (pg) {
> +	case CACHE_MPAGE:
> +		if (ata_mselect_caching(tf, p, pg_len))
> +			goto invalid_fld;

   Error is in the data, not CDB, so returning "invalied field in CDB" doesn't
make sense...

> +		break;
> +
> +	default:		/* invalid page code */
> +		goto invalid_fld;
> +	}
> +	return 0;
> +
> + invalid_fld:
> +	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
> +	/* "Invalid field in cbd" */

   s/cbd/CDB/

MBR, Sergei
