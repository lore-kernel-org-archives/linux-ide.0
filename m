From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 02/20] ata_piix: unify code for programming PIO and MWDMA
 timings
Date: Mon, 21 Feb 2011 14:59:08 +0300
Message-ID: <4D62538C.1010200@ru.mvista.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>	<20110208122346.19110.8441.sendpatchset@linux-mhg7.site>	<4D6118DC.80505@ru.mvista.com>	<20110220185958.364df4cc@lxorguk.ukuu.org.uk>	<4D617CC8.3020108@ru.mvista.com>	<20110220210731.0c774fa7@lxorguk.ukuu.org.uk>	<4D624EBD.4080400@ru.mvista.com> <20110221115839.2048e8fe@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f42.google.com ([209.85.215.42]:62671 "EHLO
	mail-ew0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1BUMA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2011 07:00:28 -0500
In-Reply-To: <20110221115839.2048e8fe@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 21-02-2011 14:58, Alan Cox wrote:

>>>>       PIO mode is setup by different code, and it takes care of the IORDY
>>>> setting according to the PIO rules (and it gets called). DMA mode setup should
>>>> just ignore the IORDY setting as in all other sane drivers.

>>> Well it can't ignore it - but if you mean just keep the bit as is then

>>      Yes, I mean this.

>>> that sounds sensible, have to see what the docs say happens if you ever
>>> set MWDMA without IORDY.

>>      Don't think they say anything on this matter but I can't imagine that
>> IORDY matters for DMA.

    ... unless the IE bit means something special (and undocumented) for DMA, 
if Intel so insists on setting it for every DMA mode.

> Sure - but it does matter for an ATAPI transaction with then has a DMA
> phase because those timings will be used for the command transfer which
> is PIO.

    So what? We've already setup PIO timings before the DMA ones. Why force 
the IE bit?

> Alan

WBR, Sergei
