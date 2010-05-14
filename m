From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: kill ata_irq_on() prototype
Date: Fri, 14 May 2010 17:24:41 -0400
Message-ID: <4BEDBF99.8010006@pobox.com>
References: <201005062215.22697.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:34724 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0ENVYn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:24:43 -0400
Received: by mail-yx0-f191.google.com with SMTP id 29so1239276yxe.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:24:43 -0700 (PDT)
In-Reply-To: <201005062215.22697.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 05/06/2010 02:15 PM, Sergei Shtylyov wrote:
> Commit 9363c3825ea9ad76561eb48a395349dd29211ed6 renamed ata_irq_on() to
> ata_sff_irq_on() but forgot to rename its prototype in "libata.h". This
> prototype is duplicate anyway, as the function is already declared in
> <linux/libata.h>, so remove it...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/libata.h |    1 -
>   1 file changed, 1 deletion(-)

applied


