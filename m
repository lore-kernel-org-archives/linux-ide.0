From: Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 17:44:10 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FA1943A.7010300@cornell.edu>
References: <200310301601.55588.schlicht@uni-mannheim.de> <20031030133316.6bd00b4a.akpm@osdl.org> <200310302310.53798.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:1715 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262894AbTJ3Wik (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2003 17:38:40 -0500
In-Reply-To: <200310302310.53798.schlicht@uni-mannheim.de>
List-Id: linux-ide@vger.kernel.org
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi, perhaps this might also be relevant:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1655.html

Have those issues here been finally addressed?
I haven't been following development much lately, but I wanted to ask, 
since at the moment I have no confidence in TCQ. I know #1 has been 
fixed. Have there been any major TCQ changes that I need to retest for?

The only thing I see is this:

ChangeSet@1.1153.141.3, 2003-09-05 07:15:37-07:00, 
B.Zolnierkiewicz@elka.pw.edu.pl
   [PATCH] ide: fix ide_cs oops with TCQ

Thomas Schlichter wrote:
> Hello again...
> 
> On Thursday 30 October 2003 22:33, Andrew Morton wrote:
> 
>>Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>>
>>> today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The
>>>config.gz is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda'
>>>newly started processes die due to a received SIGSEGV. No bad kernel
>>>messages appear...


