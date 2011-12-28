From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Wed, 28 Dec 2011 20:56:13 +0300
Message-ID: <4EFB583D.1000306@mvista.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59338 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab1L1Q5U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2011 11:57:20 -0500
Received: by wibhm6 with SMTP id hm6so5718433wib.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Dec 2011 08:57:19 -0800 (PST)
In-Reply-To: <201112281836.45834.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, sonic.zhang@analog.com

Hello.

On 12/28/2011 06:36 PM, Sergei Shtylyov wrote:

> The author of this driver clearly wasn't familiar with the BMIDE specification
> (also known as SFF-8038i) when he implemented the bmdma_status() method: first,
> the interrupt bit of the BMIDE status register corresponds to nothing else but
> INTRQ signal (ATAPI_DEV_INT here); second, the error bit is only set if the
> controller encounters issue doing the bus master transfers, not on the DMA burst
> termination interrupts like here

    Forgot to say that burst terminations are happening on the IDE side.

> (moreover, setting the error bit doesn't cause an interrupt).

> (The only thing I couldn't figure out is how to flush the FIFO to memory once
> the interrupt happens as required by the mentioned spec.)

> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

WBR, Sergei
