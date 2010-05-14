From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_cmd640: don't read CFR pointlessly
Date: Fri, 14 May 2010 17:32:49 -0400
Message-ID: <4BEDC181.8040508@pobox.com>
References: <201005082227.19096.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62195 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab0ENVcv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:32:51 -0400
Received: by gwj19 with SMTP id 19so1561211gwj.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:32:51 -0700 (PDT)
In-Reply-To: <201005082227.19096.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 05/08/2010 02:27 PM, Sergei Shtylyov wrote:
> cmd640_hardware_init() reads CFR but doesn't use the value read...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_cmd640.c |    3 ---
>   1 file changed, 3 deletions(-)

applied


