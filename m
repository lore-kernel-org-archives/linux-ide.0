From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sx4: pdc20621_{ata|host}_sg() do not need 'tf' parameter
Date: Wed, 28 Nov 2012 12:43:09 -0500
Message-ID: <50B64D2D.4000506@pobox.com>
References: <201210252119.13022.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47813 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab2K1RnM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:43:12 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so5083024qat.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2012 09:43:11 -0800 (PST)
In-Reply-To: <201210252119.13022.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 10/25/2012 01:19 PM, Sergei Shtylyov wrote:
> ... because those functions don't use this parameter.
>
> While at it, correctly align 'total_len' parameter.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> ---
> The patch is atop of the 'upstream' branch of libata-dev.git...
>
>   drivers/ata/sata_sx4.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

applied



