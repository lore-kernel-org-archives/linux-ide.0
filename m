From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new cleanup
Date: Fri, 01 Dec 2006 15:36:18 +0300
Message-ID: <457021C2.3040703@ru.mvista.com>
References: <200611302151.33319.sshtylyov@ru.mvista.com> <20061201001321.1b946f0e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36829 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1031179AbWLAMew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2006 07:34:52 -0500
In-Reply-To: <20061201001321.1b946f0e@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Alan wrote:
> I believe this is completely the wrong thing to do. Adding a ton of
> changes to the existing (and stable) life expired drivers/ide driver
> rather than keeping new and risky stuff in the new libata code is bad.

    The new and risky stuff is long agon in there.

> The existing code *works*, its been rock solid since the reset drain fix

    Don't make me laugh. pdc202xx_new certainly doesn't deserve these 
compliments.  It has known PLL problems even on x86 if you have more than 2 
contorollers, and on non-x86 this turns into its complete inability to support 
anything above UltraDMA/33.

> and it is the code everyone who is conservative relies on not to eat
> their data. We have somewhere to do new and cool stuff its libata.

    I'm not interested in libata development currently, and interested in 
fixing the age-old crap in drivers/ide/.

> I don't see the point in risking destabilising a good solid driver. I can
> just about see justification for !X86 implementation of the PLL handling
> but that is about it.

    All in a good time.

> Alan

WBR, Sergei
