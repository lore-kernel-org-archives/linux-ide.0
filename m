From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 05 Jul 2010 11:33:19 +0200
Message-ID: <4C31A6DF.9080109@gmail.com>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com> <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com> <4C319741.3060602@denx.de> <4C319D31.60705@gmail.com> <4C31A519.7030806@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49944 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab0GEJd2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 05:33:28 -0400
Received: by bwz1 with SMTP id 1so2588758bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Jul 2010 02:33:22 -0700 (PDT)
In-Reply-To: <4C31A519.7030806@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hs@denx.de
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

On 07/05/2010 11:25 AM, Heiko Schocher wrote:
>> Yeah, that's the new polling code kicking in.  If the IRQ problem
>> doesn't persiste (which should be the case here), polling will step
>> down after a while and everything will return to normal.  If you keep
>> the system running more than ten minutes and use the CF device, does
>> the kernel complain anymore?
> 
> No, I can use the CF while kernel is in polling mode, also if the
> kernel switched back to irq mode:
> 
> Log, direct after kernel is up:
> 
..
>  25:          9   MPC8XX SIU       Level        pata_pcmcia
>  26:      10000   MPC8XX SIU       Level        pata_pcmcia
...
> 
> No irq is used.
> 
> -bash-3.2# dmesg
> [...]
> Freeing unused kernel memory: 132k init
> IRQ 26: spurious polling finished, reenabling IRQ
> -bash-3.2#
> 
> Now it is back in irq mode:
> 
> -bash-3.2# cat /proc/uptime
> 419.65 370.56
> -bash-3.2#
> 
...
>  25:          9   MPC8XX SIU       Level        pata_pcmcia
>  26:      10033   MPC8XX SIU       Level        pata_pcmcia

Cool, so it works as expected.  With the new lost/spurious IRQ
handling in place, removing TFLAG_POLLING from read_id for all
controllers shouldn't cause much problem.  However, the CF device is a
pretty rare corner case and spurious IRQ handling can deal with it
without too much problem, so leaving things as it is is probably
better.

Thanks for testing.

-- 
tejun
