From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] pata_hpt3x2n: always stretch UltraDMA timing
Date: Thu, 17 Dec 2009 01:21:26 -0500
Message-ID: <4B29CDE6.1050304@pobox.com>
References: <200912072225.52223.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47843 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761505AbZLQGV3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:21:29 -0500
Received: by yxe17 with SMTP id 17so1667470yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:21:29 -0800 (PST)
In-Reply-To: <200912072225.52223.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

On 12/07/2009 02:25 PM, Sergei Shtylyov wrote:
> The UltraDMA Tss timing must be stretched with ATA clock of 66 MHz, but the
> driver only does this when PCI clock is 66 MHz, whereas it always programs
> DPLL clock (which is used as the ATA clock) to 66 MHz.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> Cc:<stable@kernel.org>
>
> ---
> The patch is against the recent Linus' tree. It's intended to go into all
> stable kernels up to 2.6.22 -- when HPT371N support was merged.
>
>   drivers/ata/pata_hpt3x2n.c |   20 ++++++++++----------
>   1 files changed, 10 insertions(+), 10 deletions(-)

applied 1-5


