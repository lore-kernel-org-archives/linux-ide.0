From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.29-davinci1 git] dm6446evm CF support
Date: Wed, 01 Apr 2009 22:12:25 +0400
Message-ID: <49D3AE89.1080500@ru.mvista.com>
References: <200904010308.13718.david-b@pacbell.net> <49D35C38.7070107@ru.mvista.com> <200904011009.10608.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50157 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933435AbZDASLy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 14:11:54 -0400
In-Reply-To: <200904011009.10608.david-b@pacbell.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: DaVinci <davinci-linux-open-source@linux.davincidsp.com>, linux-ide@vger.kernel.org

Hello.

David Brownell wrote:

>>>+config MACH_DAVINCI_EVM_CF
>>>+     bool "Use CompactFlash, not IDE drive"
>>>+     depends on MACH_DAVINCI_EVM && BLK_DEV_PALMCHIP_BK3710
>>>+     help
>>>+       Enable this if you want to use a CompactFlash card instead of
>>>+       an IDE/ATA drive.  The CF card will be used in "True IDE" mode.
>>>+
>>>+       At this writing, CF insert and remove events are not supported.
>>>+       Insert the CF at boot time, and leave it there until you power
>>>+       the system off.
>>>+

>>    This instruction is already obsolete. As I've already noted, IDE core now 
>>supports warm plug via sysfs, see Documentation/ide/warm-plug-howto.txt. One 
>>can plug and unplug any time, this just won't be automatically noticed by the 
>>kernel, so one will need to notify it.

> CF insert and remove events are very different from writing
> some sysfs files.  They are handled through a pcmcia_socket
> abstraction ... and are completely hands-off.  Socket events
> include card insert/removal detection, and socket operations
> include power on/off and reset.  I don't know that "true-IDE"
> links work through those sockets, though.

> That said ... I tried that manual workaround; it didn't work.

> So:  no, that instruction is far from obsolete.

    So, it would only work with real hard disks... sigh. Sorry for 
disinformation then -- I hoped warm plug could've been helpful for CF.

MBR, Sergei
