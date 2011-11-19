From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: PATCH: Add CFA modes
Date: Sat, 19 Nov 2011 17:29:11 +0400
Message-ID: <4EC7AF27.2050704@ru.mvista.com>
References: <1155232332.24077.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:43514 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751809Ab1KSNcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Nov 2011 08:32:05 -0500
In-Reply-To: <1155232332.24077.7.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 10-08-2006 21:52, Alan Cox wrote:

>> From nobody Mon Sep 17 00:00:00 2001
> From: root<root@hraefn.swansea.linux.org.uk>
> Date: Thu Aug 10 18:06:38 2006 +0100
> Subject: [PATCH] Add compact flash support

> The CFA world has some additional rules and drive modes we need to support for
> newer expansion cards and on embedded boxes

    Sorry, this is very old patch,

> @@ -1913,6 +1945,8 @@ static const struct ata_timing ata_timin
>   	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
>   	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
>
> +	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
> +	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },

    I keep wondering where you got these 25 ns setup timings and where such 
numbers for modes 0-2 came from -- they're not in any spec.

MBR, Sergei

