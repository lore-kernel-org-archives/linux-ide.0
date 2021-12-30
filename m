Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE7BC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 05:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhL3FN3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 00:13:29 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:18610 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229448AbhL3FN1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 00:13:27 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPbyY6wryz1RvTg
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2021 21:13:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640841205; x=1643433206; bh=1HZ37Y7RTDaWzoPZIUCNus80vIUntvdAsIn
        gZGmRvxQ=; b=AcH8ZSbrV71ucPDjae7IstKwZ8VGPV1fJskrJpiKAIINhOKyGIt
        Y4pvd6hF9JuQclOW9OdxX7gO0VZPuDkEfejO4bkY0b7gJG0Npv1P7jUkjx9lfDjJ
        HyfbV/aOkezR4DgBy58w3dCmFzH3kc4a3BWWnHJyyTyAJ1Mxntm3wH+XMvYJ7t+2
        eAa/A8n+AM/qtNPutqivKk5MaqUwmnhWA6JJlAgRso2fZ1rfZGeW0Z8o/5bUHe/e
        lHB+VhnqJkHvrJru0F3NSxoCOlbA6YjZAzoudk8CXVtuunD62ceioXya+czx4cqN
        3IdIsz+n4s1AYDpMPTAZkKHtW+TCDjQDjoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4dgUR90clbxe for <linux-ide@vger.kernel.org>;
        Wed, 29 Dec 2021 21:13:25 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPbyY21NYz1RtVc;
        Wed, 29 Dec 2021 21:13:25 -0800 (PST)
Message-ID: <9c7dd2c6-7cca-4124-af9e-9a1d6f0ef054@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 14:13:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 13/68] libata: revamp ata_get_cmd_descript()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-14-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221072131.46673-14-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/21/21 16:20, Hannes Reinecke wrote:
> Rename ata_get_cmd_descrip() to ata_get_cmd_name() and simplify
> it to return "unknown" instead of NULL.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-acpi.c |  4 +---
>  drivers/ata/libata-eh.c   | 22 +++++++++-------------
>  drivers/ata/libata.h      |  2 +-
>  3 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 7007377880ce..9e1e62b9cf63 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -664,9 +664,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  		pptf = &ptf;
>  	}
>  
> -	descr = ata_get_cmd_descript(tf.command);
> -	if (!descr)
> -		descr = "unknown";
> +	descr = ata_get_cmd_name(tf.command);
>  
>  	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
>  		rtf = tf;
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 69f51616d8bd..8bf52a6239aa 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2080,16 +2080,15 @@ void ata_eh_autopsy(struct ata_port *ap)
>  }
>  
>  /**
> - *	ata_get_cmd_descript - get description for ATA command
> - *	@command: ATA command code to get description for
> + *	ata_get_cmd_name - get name for ATA command
> + *	@command: ATA command code to get name for
>   *
> - *	Return a textual description of the given command, or NULL if the
> - *	command is not known.
> + *	Return a textual name of the given command or "unknown"
>   *
>   *	LOCKING:
>   *	None
>   */
> -const char *ata_get_cmd_descript(u8 command)
> +const char *ata_get_cmd_name(u8 command)
>  {
>  #ifdef CONFIG_ATA_VERBOSE_ERROR
>  	static const struct
> @@ -2197,9 +2196,9 @@ const char *ata_get_cmd_descript(u8 command)
>  			return cmd_descr[i].text;
>  #endif
>  
> -	return NULL;
> +	return "unknown";
>  }
> -EXPORT_SYMBOL_GPL(ata_get_cmd_descript);
> +EXPORT_SYMBOL_GPL(ata_get_cmd_name);
>  
>  /**
>   *	ata_eh_link_report - report error handling to user
> @@ -2348,12 +2347,9 @@ static void ata_eh_link_report(struct ata_link *link)
>  			}
>  			__scsi_format_command(cdb_buf, sizeof(cdb_buf),
>  					      cdb, cdb_len);
> -		} else {
> -			const char *descr = ata_get_cmd_descript(cmd->command);
> -			if (descr)
> -				ata_dev_err(qc->dev, "failed command: %s\n",
> -					    descr);
> -		}
> +		} else
> +			ata_dev_err(qc->dev, "failed command: %s\n",
> +				    ata_get_cmd_name(cmd->command));

You should have kept the curly brackets here since the "if" part has
them. Fixed that.

>  
>  		ata_dev_err(qc->dev,
>  			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 4a8f4623cfe5..2144065e762c 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -166,7 +166,7 @@ extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
>  extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
>  			unsigned int action);
>  extern void ata_eh_autopsy(struct ata_port *ap);
> -const char *ata_get_cmd_descript(u8 command);
> +const char *ata_get_cmd_name(u8 command);
>  extern void ata_eh_report(struct ata_port *ap);
>  extern int ata_eh_reset(struct ata_link *link, int classify,
>  			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,


-- 
Damien Le Moal
Western Digital Research
