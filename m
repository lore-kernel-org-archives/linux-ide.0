From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] ata: ata-samsung_cf: Trivial cleanup in header file
Date: Fri, 14 Feb 2014 17:28:28 +0400
Message-ID: <52FE19FC.7010905@cogentembedded.com>
References: <1392359102-6997-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:46802 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaBNN2Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Feb 2014 08:28:25 -0500
Received: by mail-la0-f52.google.com with SMTP id c6so9393905lan.11
        for <linux-ide@vger.kernel.org>; Fri, 14 Feb 2014 05:28:24 -0800 (PST)
In-Reply-To: <1392359102-6997-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-ide@vger.kernel.org
Cc: trivial@kernel.org, tj@kernel.org

Hello.

On 14-02-2014 10:25, Sachin Kamat wrote:

> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the files to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

> ---
>   include/linux/platform_data/ata-samsung_cf.h |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

> diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
> index 2a3855a8372a..064f86329219 100644
> --- a/include/linux/platform_data/ata-samsung_cf.h
> +++ b/include/linux/platform_data/ata-samsung_cf.h
[...]
> @@ -10,8 +9,8 @@
>    * published by the Free Software Foundation.
>   */
>
> -#ifndef __ASM_PLAT_ATA_H
> -#define __ASM_PLAT_ATA_H __FILE__
> +#ifndef __ATA_SAMSUNG_CF_ATA_H
> +#define __ATA_SAMSUNG_CF_ATA_H __FILE__

    Why not just __ATA_SAMSUNG_CF_H?

WBR, Sergei

