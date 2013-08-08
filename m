From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Thu, 08 Aug 2013 21:52:16 +0400
Message-ID: <5203DAD0.6040604@cogentembedded.com>
References: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com> <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:53488 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965829Ab3HHRwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 13:52:12 -0400
Received: by mail-la0-f42.google.com with SMTP id mf11so2306469lab.29
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 10:52:10 -0700 (PDT)
In-Reply-To: <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 08/08/2013 11:16 AM, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> Add support for the following ATA opcodes, which are present
> in SATA 3.1 and T13 ATA ACS-3:

>          SEND FPDMA QUEUED
>          RECEIVE FPDMA QUEUED

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
[...]

> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 1145637..f9e4fd8 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -388,4 +388,12 @@ static inline int ahci_nr_ports(u32 cap)
>   	return (cap & 0x1f) + 1;
>   }
>
> +static inline void ahci_h2dfis_set_auxiliary(u8 *fis, u32 aux)
> +{
> +	fis[16] = aux & 0xff;
> +	fis[17] = (aux >> 8) & 0xff;
> +	fis[18] = (aux >> 16) & 0xff;
> +	fis[19] = (aux >> 24) & 0xff;
> +}
> +
>   #endif /* _AHCI_H */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index acfd0f7..52668f4 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1499,6 +1499,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
>   	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
>
>   	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
> +	ahci_h2dfis_set_auxiliary(cmd_tbl, qc->auxiliary);
>   	if (is_atapi) {
>   		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
>   		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);

    How about non-AHCI FIS-based controllers?

WBR, Sergei

