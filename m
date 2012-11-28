From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] pata_arasan_cf: declare/use more local variables in
 arasan_cf_dma_start()
Date: Wed, 28 Nov 2012 12:42:47 -0500
Message-ID: <50B64D17.8040706@pobox.com>
References: <201211011828.36550.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64936 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab2K1Rmv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:42:51 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9856987qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2012 09:42:50 -0800 (PST)
In-Reply-To: <201211011828.36550.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, viresh.linux@gmail.com

On 11/01/2012 11:28 AM, Sergei Shtylyov wrote:
> 'acdev->qc', 'acdev->qc->ap', and 'acdev->qc->tf' expressions are used multiple
> times in this function, so it makes sense to use the local variables for them.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> The patch is atop of the 'upstream' branch of libata-dev.git...
>
>   drivers/ata/pata_arasan_cf.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

applied



