From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Sat, 23 Jun 2007 22:10:34 +0400
Message-ID: <467D621A.80406@ru.mvista.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com> <467BEB9C.1070407@ru.mvista.com> <20070622163646.GG8840@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15142 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752755AbXFWSIx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 14:08:53 -0400
In-Reply-To: <20070622163646.GG8840@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org

Hello.

Linas Vepstas wrote:

>>>>Reset HPT36x's DMA state machine on a DMA timeout the way it's done for 
>>>>HPT370.
>>>>drivers/ide/pci/hpt366.c |   24 +++++++++++++++++++++++-

>>>This worked great!  

>>   I hope you meant those messages were preceeded by DMA timeouts 
>>   (otherwise this code wouldn't come into action).

> Oops, I was wrong ... 

> Scads of 
> Jun 21 20:22:30 localhost kernel: [  434.574301] hdc: task_out_intr:
> status=0x50 { DriveReady SeekComplete }
> Jun 21 20:22:30 localhost kernel: [  434.574318] ide: failed opcode was:
> unknown

>>>from it (I put in a printk to verify this).

>>   You mean into my ide_dma_timeout() method?

> Ooops, I lied. I have so many printk's in there, that I got confused.
> No, in fact, it looks like I did NOT see your handler run. 

    Now I'm confused too -- did you get any DMA timeouts this time?

> --linas

MBR, Sergei
