From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Date: Tue, 6 Nov 2007 03:49:13 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0711060348290.22998@trinity.phys.uwm.edu>
References: <56020.194.255.108.253.1192004925.squirrel@root.dusted.dk>
 <20071012174153.69556b32.akpm@linux-foundation.org> <47105C53.7040603@lix-world.net>
 <471DC52B.20802@gmail.com> <471F2647.4030304@lix-world.net> <47214593.1080102@gmail.com>
 <20071026040226.GA26960@jim.sh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:34129 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbXKFJyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 04:54:43 -0500
In-Reply-To: <20071026040226.GA26960@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Tejun Heo <htejun@gmail.com>, Steen Eugen Poulsen <sep@lix-world.net>, Andrew Morton <akpm@linux-foundation.org>, lists@dusted.dk, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, bruce.allen@aei.mpg.de

>>>> All these are caused by smartd.  Updating should fix the problem.
>>>
>>> Okay, but there is no newer smartd than what I'm using. (5.37)
>>
>> Bruce?  Original thread can be read from...
>>
>> http://thread.gmane.org/gmane.linux.kernel/588972
>
> The fixes were added in smartmontools CVS, but there hasn't been a
> release since then.

I think we'll do a new smartmontools release fairly soon.

Cheers,
 	Bruce
