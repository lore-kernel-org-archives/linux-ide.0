From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Tue, 16 Oct 2007 15:53:09 +0400
Message-ID: <4714A625.8040306@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <4713A010.3080504@ru.mvista.com> <200710152339.33718.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:19610 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759905AbXJPLw5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 07:52:57 -0400
In-Reply-To: <200710152339.33718.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Martin Rogge wrote:

>>    Could you git-bisect this?
>>    Although I have a couple of patch suspects (dealing with interrupts),
>>all worked fine with PCI-649 just fine. PCI-648 is not really much
>>different from 649 according to specs...

> Yes, I found the same when I managed to send the CMD 648 into UDMA-100 mode years ago (by treating it like a 649).

> Anyway, I found the git patches on kernel.org and bisected away. For completeness, this is the table containing all my results.

> Kernel         System reaction
> ============================================================================
> 2.6.21         CMD 648 working fine
> 2.6.21-git4    CMD 648 working fine
> 2.6.21-git5    CMD 648 working fine
> 2.6.21-git6    irg 15: nobody cared [...] Disabling IRQ #15 etc.
> 2.6.21-git8    irg 15: nobody cared [...] Disabling IRQ #15 etc.
> 2.6.22-rc1     irg 15: nobody cared [...] Disabling IRQ #15 etc.
> 2.6.22         irg 15: nobody cared [...] Disabling IRQ #15 etc.
> 2.6.23         irg 15: nobody cared [...] Disabling IRQ #15 etc.

> Well, most likely the CMD related patches in git6 are the culprit. 

    Erm... usually bisection leaves you with one patch startting from which 
kernel was broken.  It seems you've done sort iof manual bisecting. Thanks 
anyway. :-)

> Regards,

> cu Martin

MBR, Sergei
