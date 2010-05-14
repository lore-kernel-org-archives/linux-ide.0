From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2 v2] ahci: EM message type auto detect
Date: Fri, 14 May 2010 17:24:24 -0400
Message-ID: <4BEDBF88.4030906@pobox.com>
References: <1272014839.3594.41.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:34724 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab0ENVY1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:24:27 -0400
Received: by yxe29 with SMTP id 29so1239276yxe.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:24:27 -0700 (PDT)
In-Reply-To: <1272014839.3594.41.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org, shane.huang@amd.com

On 04/23/2010 05:27 AM, Harry Zhang wrote:
> To detect enclosure management message type automatically at driver
> initialization, instead of using module parameter "ahci_em_messages".
>
> Signed-off-by: Harry Zhang<harry.zhang@amd.com>
> ---
> v2: Move this patch to the first one.
>
>   drivers/ata/ahci.c    |    2 +-
>   drivers/ata/ahci.h    |    8 +++++++-
>   drivers/ata/libahci.c |   38 ++++++++++++++++++++------------------
>   3 files changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c44d112..8ca16f5 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1185,7 +1185,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>   		/* set enclosure management message type */
>   		if (ap->flags&  ATA_FLAG_EM)
> -			ap->em_message_type = ahci_em_messages;
> +			ap->em_message_type = hpriv->em_msg_type;
>
>
>   		/* disabled/not-implemented port */

you missed ahci_platform.c update.

applied 1-2, and fixed up this problem


