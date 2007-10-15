From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Mon, 15 Oct 2007 21:14:56 +0400
Message-ID: <4713A010.3080504@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10485 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755181AbXJOROp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 13:14:45 -0400
In-Reply-To: <200710142211.03382.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Martin Rogge wrote:

> Hi Sergei and Bartlomiej,
> 
> I have read in the changelog that both of you got linux kernel patches into 
> 2.6.22-rc1 for the cmd64x driver. I found that some patches introduced in 
> 2.6.22-rc1 break the CMD648 operation of one of my machines. (Actually I 
> discovered it in 2.6.23 but since then verified that the fatal change was 
> introduced between 2.6.21 and 2.6.22-rc1.) 

> Your 2.6.22-rc1 patches may not be responsible for my problem. Nonetheless, 
> could you take a look? If you need any additional info, or need me to try 
> something out, please let me know. 

    Could you git-bisect this?
    Although I have a couple of patch suspects (dealing with interrupts), all 
worked fine with PCI-649 just fine. PCI-648 is not really much different from 
649 according to specs...

> Below I copied the mail I sent to lkml a few days ago. So far I have received 
> no reaction.

    I'm not reading LKML, so CC your further mails to linux-ide@vger.kernel.org...

WBR, Sergei
