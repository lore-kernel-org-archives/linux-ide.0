From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 0063/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:30:48 +0300
Message-ID: <5391e340-1285-574d-1979-a19571341eb5@cogentembedded.com>
References: <20160802103759.17958-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36551 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408AbcHBLcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2016 07:32:23 -0400
Received: by mail-lf0-f45.google.com with SMTP id g62so135947971lfe.3
        for <linux-ide@vger.kernel.org>; Tue, 02 Aug 2016 04:30:51 -0700 (PDT)
In-Reply-To: <20160802103759.17958-1-baolex.ni@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, b.zolnierkie@samsung.com, tj@kernel.org, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, travis@sgi.com

Hello.

On 8/2/2016 1:37 PM, Baole Ni wrote:

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/ata/pata_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index bce2a8c..1dc0beb 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -76,7 +76,7 @@
>  #define NR_HOST 6
>
>  static int all;
> -module_param(all, int, 0444);
> +module_param(all, int, S_IRUSR | S_IRGRP | S_IROTH);

    There's S_IRUGO for this case, no?

MBR, Sergei

