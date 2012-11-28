From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil24: remove unused variable from sata_sil24.c
Date: Wed, 28 Nov 2012 12:43:26 -0500
Message-ID: <50B64D3E.8050105@pobox.com>
References: <CAPgLHd_tvQysNUQ6vuMh_GEjEiRaMeAj-aiPq7YDkKeBQz49QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51683 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab2K1Rn3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:43:29 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9857430qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2012 09:43:28 -0800 (PST)
In-Reply-To: <CAPgLHd_tvQysNUQ6vuMh_GEjEiRaMeAj-aiPq7YDkKeBQz49QQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

On 10/22/2012 05:02 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> The variable addr is initialized but never used
> otherwise, so remove the unused variable.
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>   drivers/ata/sata_sil24.c | 4 ----
>   1 file changed, 4 deletions(-)

applied this, and two others of similar nature



