From: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Fri, 31 Oct 2003 18:37:31 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FA2113B.1020102@cyberone.com.au>
References: <200310301601.55588.schlicht@uni-mannheim.de> <3FA1943A.7010300@cornell.edu> <3FA1A171.3040807@cyberone.com.au> <200310310828.41598.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-03.iinet.net.au ([203.59.3.35]:49577 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263060AbTJaHhf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Oct 2003 02:37:35 -0500
In-Reply-To: <200310310828.41598.schlicht@uni-mannheim.de>
List-Id: linux-ide@vger.kernel.org
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org



Thomas Schlichter wrote:

>Hi,
>
>On Friday 31 October 2003 00:40, Nick Piggin wrote:
>
>>Hi,
>>If you're testing IDE TCQ, please try the following patch and use the
>>default io scheduler. It won't fix anything, but it poisons requests
>>so we can sometimes tell if they are being used in the wrong places.
>>I have seen warnings that lead me to believe this might be happening.
>>Its against 2.6.0-test9-mm1. Report any stack traces you see. Thanks.
>>
>
>OK, I tested 2.6.0-test9-mm1 + your patch, but it seems not to print any 
>messages or stack traces, even if many processes are killed after setting TCQ 
>depth to 1.
>

OK well thats good, its not my problem then ;) Thanks.


