From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v1] libata: export ata_get_cmd_descript()
Date: Fri, 12 Dec 2014 20:25:56 +0300
Message-ID: <548B2524.9050806@cogentembedded.com>
References: <1418397391-13668-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:58593 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031083AbaLLR0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 12:26:01 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so6500305lab.13
        for <linux-ide@vger.kernel.org>; Fri, 12 Dec 2014 09:26:00 -0800 (PST)
In-Reply-To: <1418397391-13668-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 12/12/2014 06:16 PM, Andy Shevchenko wrote:

> The driver sata_dwc_460ex is using this symbol. To build it as a module we have
> to have the symbol exported. This patch adds EXPORT_SYMBOL() macro for that.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ata/libata-eh.c | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3dbec89..74fef87 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2389,6 +2389,7 @@ const char *ata_get_cmd_descript(u8 command)
>
>   	return NULL;
>   }
> +EXPORT_SYMBOL(ata_get_cmd_descript);

    Why not EXPORT_SYMBOL_GPL()?

MBR, Sergei

