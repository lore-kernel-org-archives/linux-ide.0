From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-core: set debug logging via module param
Date: Fri, 18 Apr 2008 16:18:01 +0400
Message-ID: <48089179.40503@ru.mvista.com>
References: <20080417230406.GA6266@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10826 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752271AbYDRMSp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 08:18:45 -0400
In-Reply-To: <20080417230406.GA6266@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Hello.

David Milburn wrote:

> Set debug level using ata_logging_level module parameter.

> Signed-off-by David Milburn <dmilburn@redhat.com>

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 733eb94..3fac7f7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -158,6 +158,10 @@ int libata_allow_tpm = 0;
>  module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
>  MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands");
>  
> +unsigned int ata_logging_level;
> +module_param(ata_logging_level, int, 0444);
> +MODULE_PARM_DESC(ata_logging_level, "Bit mask of logging levels");
> +
>  MODULE_AUTHOR("Jeff Garzik");
>  MODULE_DESCRIPTION("Library module for ATA devices");
>  MODULE_LICENSE("GPL");
> @@ -5190,14 +5194,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	ap->dev = host->dev;
>  	ap->last_ctl = 0xFF;
>  
> -#if defined(ATA_VERBOSE_DEBUG)
> -	/* turn on all debugging levels */
> -	ap->msg_enable = 0x00FF;
> -#elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
> -#else
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
> -#endif
> +	/* set debugging level */
> +	ap->msg_enable = ata_logging_level;

    This sets the default mask to show no log messages instead of ATA_MSG_DRV 
| ATA_MSG_ERR | ATA_MSG_WARN as it was before the patch.

WBR, Sergei
