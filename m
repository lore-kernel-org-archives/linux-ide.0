From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] [libata]Set proper SK when CK_COND is set.
Date: Fri, 18 Jan 2013 15:17:57 +0400
Message-ID: <50F92F65.6060904@mvista.com>
References: <1358475510-23949-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:57118 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3ARLSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2013 06:18:10 -0500
Received: by mail-la0-f53.google.com with SMTP id fn20so3654510lab.26
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2013 03:18:08 -0800 (PST)
In-Reply-To: <1358475510-23949-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 18-01-2013 6:18, Gwendal Grignou wrote:

> When the user application sends a ATA_12 or ATA_16 PASSTHROUGH
> scsi command, put the task file register in the sense data with the
> proper Sense Key. Instead of NO SENSE, set RECOVERED, as
> specified in [SAT2]12.2.5 Table 92.

> Change-Id: Ia7d77d09f6db6db4796310b4dc9789ac0d7af69b

    Remove this line please.

> Tested:
> Using udev ata_id to generate a passthrough command, IDENTIFY:
> before:
>   sd 0:0:0:0: [sda] CDB: ATA command pass through(12)/Blank: \
> a1 08 2e 00 01 00 00 00 00 ec 00 00
>   sd 0:0:0:0: [sda] Sense Key : No Sense [current] [descriptor]
>   Descriptor sense data with sense descriptors (in hex):
>           72 00 00 00 00 00 00 0e 09 0c 00 00 00 00 00 3f
>           00 18 00 a6 e0 50

> after
>   sd 0:0:0:0: [sda] CDB: ATA command pass through(12)/Blank: \
> a1 08 2e 00 01 00 00 00 00 ec 00 00
>   sd 0:0:0:0: [sda]  Sense Key : Recovered Error [current] [descriptor]
>   Descriptor sense data with sense descriptors (in hex):
>          72 01 00 1d 00 00 00 0e 09 0c 00 00 00 01 00 00
>          00 00 00 00 00 50

> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> ---
>   drivers/ata/libata-scsi.c |   18 ++++++++++++++----
>   1 files changed, 14 insertions(+), 4 deletions(-)

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7c337e7..d5f81b2 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[...]
> @@ -1733,10 +1741,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>
>   	/* For ATA pass thru (SAT) commands, generate a sense block if
>   	 * user mandated it or if there's an error.  Note that if we
> -	 * generate because the user forced us to, a check condition
> -	 * is generated and the ATA register values are returned
> +	 * generate because the user forced us to [CK_COND =1 ], a check

    Space before ] not needed.

MBR, Sergei

