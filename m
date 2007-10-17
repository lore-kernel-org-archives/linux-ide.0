From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Thu, 18 Oct 2007 00:40:21 +0400
Message-ID: <47167335.1020903@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <4714B1E6.9070308@rtr.ca> <200710170014.28037.bzolnier@gmail.com> <200710172115.13068.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34856 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755448AbXJQUkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 16:40:09 -0400
In-Reply-To: <200710172115.13068.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello.

Martin Rogge wrote:

>>Martin, could you run git-bisect (http://kerneltrap.org/node/11753 - sorry
>>for not explaining the procudure myself but Linus did it really well)
>>starting with:

>>	git bisect good 688a87d145e04f6761c63e7f2e19fd9b3e4ca060
>>	git bisect bad 826a1b6502d0d1d67fc41043fc831e90f2ef5835

>>The "good" one is the last commit before cmd64x changes and the "bad" one
>>is the first commit after them.  Since there is only 5 commits in between
>>it should be really quick find the bad one (worst-case: 3
>>recompiles/reboots).
> 
> 
> I'll do my best. I appear to have git 1.5.2.2 on my machine, but I've never 
> used it. In the old days we used not to have such luxury!

> Give me a few days. I shall report back. 

    BTW, can you try adding #define DEBUG to the driver meanwhile?..

> cu Martin

WBR, Sergei
