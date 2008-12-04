From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Thu, 04 Dec 2008 19:17:16 +0300
Message-ID: <4938028C.4040905@ru.mvista.com>
References: <E1L4UpB-0007ro-1g@localhost>	<492A8306.9000400@ru.mvista.com>	<b2b2f2320812031839q43eb6102jbae0fbddd9a1cf75@mail.gmail.com> <20081204100717.32819f1b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23573 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbYLDQRS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 11:17:18 -0500
In-Reply-To: <20081204100717.32819f1b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Shane McDonald <mcdonald.shane@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>I am not sure how to determine if IORDY sampling is supported by a
>>drive.  If I'm reading the code correctly, other drivers only check
>>that the PIO mode is > 2 (not > 1 as in my driver) -- that seems to be
>>the case for at least piix.c, siimage.c, and it8213.c.

> Old IDE is wrong on this and in fact unless it has changed recently
> simply can't cope with and doesn't provide functions for it. A libata

    It's not as wrong as you're trying to paint it: ide_get_best_pio_mode() 
has been here for ages and it have been returning the IORDY setting -- 
although it actually asks the drive only when auto-tuning the mode, and when 
being given the explicit mode only tells to use IORDY on modes > 2.

WBR, Sergei
