From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [1/2] 2.6.22-rc6: known regressions v2
Date: Fri, 29 Jun 2007 17:01:48 -0400
Message-ID: <4685733C.1090102@garzik.org>
References: <46852187.3080504@googlemail.com>	<20070629175920.6af0c62b@the-village.bc.nu>	<468543CE.6080401@redhat.com>	<20070629190602.4ef6a0cb@the-village.bc.nu>	<46854B29.80906@garzik.org> <20070629192420.0d501a93@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60175 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbXF2VBz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 17:01:55 -0400
In-Reply-To: <20070629192420.0d501a93@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, Tejun Heo <htejun@gmail.com>, Rodney Gordon II <meff@spherevision.org>

Alan Cox wrote:
> On Fri, 29 Jun 2007 14:10:49 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>>>> I'm not even sure this report is IT8212 related rather than just an IRQ
>>>>> storm
>>>> Why does the driver report "irq 0"?
>>>>
>>>> ata7: PATA max UDMA/133 cmd <blah> ctl <blah> bmdma <blah> irq 0  <====
>>>>
>>>> Above that, the ACPI layer says it assigned IRQ 20
>>> Because the libata core code in 2.6.22rc6 reports all the ports and IRQ
>>> values wrongly ?
>> AFAIK that was fixed, for IRQ.  Please point out examples where it 
>> remains broken...
> 
> 2.6.22-rc6 it is broken, for all the systems I've looked at, as are the
> port numbers. Tejun posted fixes for the IRQ but they do not seem to have
> been applied, or if they were it was post -rc6 to a git tree.


I've seen the patch that eventually became 
22888423b3b1b96573250671afb5b72ea4364902 from Olof Johansson but nothing 
from Tejun on the subject.

	Jeff


