From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: use ATA_DMA_* constants
Date: Thu, 17 Dec 2009 01:20:10 -0500
Message-ID: <4B29CD9A.3010907@pobox.com>
References: <200912042337.43381.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:63834 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759176AbZLQGUN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:20:13 -0500
Received: by ywh12 with SMTP id 12so1994450ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:20:12 -0800 (PST)
In-Reply-To: <200912042337.43381.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/04/2009 03:37 PM, Sergei Shtylyov wrote:
> Use ATA_DMA_* constants instead of the bare numbers for the BMIDE registers.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_hpt37x.c |   19 ++++++++++---------
>   1 files changed, 10 insertions(+), 9 deletions(-)

applied


