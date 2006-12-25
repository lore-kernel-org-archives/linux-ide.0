From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: hda on Via Epia-ML motherboard seen on 2.6.18, but not 2.6.19
Date: Tue, 26 Dec 2006 06:36:45 +0800
Message-ID: <200612252236.kBPMajuC014253@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.49.234.13] ([61.49.234.13]:50119 "EHLO freya.yggdrasil.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754553AbWLYWqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Dec 2006 17:46:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

On Fri, 22 Dec 2006 14:56:20 +0100, Bartlomiej Zolnierkiewicz wrote:
>On 12/22/06, Adam J. Richter <adam@yggdrasil.com> wrote:
>>         I have a 666MHz Via Epia-ML motherboard (using a Via Eden, I
>> think).  I am booting it from a CompactFlash card attached by an
>> IDE-CF adapter.  Everything works fine under 2.6.18.  Under 2.6.19,
>> 2.6.19.1 and 2.6.20-rc1, the master device on ide0 is not seen.
[...]

>>From the quick look the only IDE subsystem change in 2.6.19
>which could be responsible (wild guess) for this is the commit:
>17c1033d331a430ce631805e15215e63b4cce764
>[ patch attached in case you don't have git tree at hand ]

>Could you check if reverting it fixes the problem?
>If not it seems that the best way to proceed is git bisect.

I'll cc this message to linux-ide in case anyone else encounters the
problem and wants to be informed about it.

As mentioned in my previous off-list email, the reverting attached
patch did not fix the problem.

I now have a few more data points to narrow where the bug was introduced:

2.6.18.4	ok
2.6.18.6	ok
2.6.19-rc1	fails

I expect I will now work on setting up a git tree fed by kernel.org
and using git bisect as you suggest.

Thanks for your advice.  I'll let you know when I have more news.


Adam Richter
