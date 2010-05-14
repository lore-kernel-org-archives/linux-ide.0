From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH resend 1/2] pata_scc: make scc_wait_after_reset() static
Date: Fri, 14 May 2010 17:24:34 -0400
Message-ID: <4BEDBF92.4060701@pobox.com>
References: <201004242029.45164.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:34724 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab0ENVYg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:24:36 -0400
Received: by mail-yx0-f191.google.com with SMTP id 29so1239276yxe.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:24:36 -0700 (PDT)
In-Reply-To: <201004242029.45164.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 04/24/2010 12:29 PM, Sergei Shtylyov wrote:
> ... since, of course, it's not used outside this driver.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree indeed now, the previously psted
> one wasn't...
>
>   drivers/ata/pata_scc.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied 1-2


