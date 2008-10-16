From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date: Thu, 16 Oct 2008 21:23:07 +0400
Message-ID: <48F7787B.2060807@ru.mvista.com>
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>	<48F7391D.8050109@ru.mvista.com> <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2542 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758563AbYJPRXY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 13:23:24 -0400
In-Reply-To: <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>>This is the driver for the Toshiba TX4939 SoC ATA controller.

>>   Mostly ACK but there's still a few minor nits...

> Welcome back!

    Indeed, it turned out to be hard to drown in the Dead see. :-)

>  I will address all of your points except for followings.

>>>+			xcount = bcount & 0xffff;
>>>+			if (xcount == 0x0000) {
>>>  

>>   Hm, I'm not sure this is necessary here... although I didn't see an 
>>explicit mention that zero count means 64 KB in the datasheet -- which 
>>it must mean if the BMIDE spec. was followed).
>>In ide-dma.c this check was added because of CS5530's brain damage...

> Hmm, if I could test this case easily I will drop this.  Otherwise I
> will keep it as is for future investigation.

    OK.

>>>+	if ((dma_stat & 7) == 0 &&
>>>+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
>>>+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
>>
>>   Parens around & and | are hardly needed...

> You mean more parens are needed?

    I mean less. :-)

> ---
> Atsushi Nemoto

MBR, Sergei
