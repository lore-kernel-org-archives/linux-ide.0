From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
 nodes
Date: Tue, 27 Nov 2007 21:07:14 +0300
Message-ID: <474C5CD2.7080208@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain> <474C3C79.5060908@ru.mvista.com> <20071127164101.GA14790@localhost.localdomain> <474C49D5.2000206@ru.mvista.com> <20071127173456.GA15693@localhost.localdomain> <474C5513.6010801@ru.mvista.com> <20071127174826.GA15980@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:45034 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755542AbXK0SHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 13:07:01 -0500
In-Reply-To: <20071127174826.GA15980@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Anton Vorontsov wrote:

>>>>>2. "ioport" because shift^Wstride ;-) applies only to the io range
>>>>>(yes, it's obvious, but worth open-wording, no?).

>>>> Contrarywise, to memory range.

>>>By io range I meant "I/O base", in contrast to "CTL base".

>>>There is no need to apply shifting for CTL. That's why ioport-*
>>>appeared in the first place.

>>   So, a matter of wrong terminology then. The thing that you meant by 
>>   "I/O" is actually called "command block".

> Yes. And IO is the second name.

    I'd say the first place in drivers/ide belongs to the historic name 
"taskfile". The "command block" which is as ATA standard calls it, is hardly used.

> It's used widespread in the drivers/ide/.

    Don't remember seeing it.

> Now you understand why I'm so reluctant to hanging up different
> labels on the single thing? ;-)

    :-)

MBR, Sergei
