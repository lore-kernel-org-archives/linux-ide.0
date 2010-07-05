From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 05 Jul 2010 10:52:01 +0200
Message-ID: <4C319D31.60705@gmail.com>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com> <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com> <4C319741.3060602@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63744 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab0GEIwJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 04:52:09 -0400
Received: by bwz1 with SMTP id 1so2565593bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Jul 2010 01:52:07 -0700 (PDT)
In-Reply-To: <4C319741.3060602@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hs@denx.de
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 07/05/2010 10:26 AM, Heiko Schocher wrote:
> IRQ 26: too many spurious IRQs, disabling and polling for 10k 10msec intervals.
> IRQ 26: system performance may be affected
> handlers:
> [<c0198d00>] (ata_sff_interrupt+0x0/0x204)

Yeah, that's the new polling code kicking in.  If the IRQ problem
doesn't persiste (which should be the case here), polling will step
down after a while and everything will return to normal.  If you keep
the system running more than ten minutes and use the CF device, does
the kernel complain anymore?

Thanks.

-- 
tejun

