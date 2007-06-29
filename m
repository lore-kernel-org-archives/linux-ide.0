From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Sat, 30 Jun 2007 00:24:23 +0400
Message-ID: <46856A77.9050808@ru.mvista.com>
References: <200706232005.10968.bzolnier@gmail.com> <200706272102.33989.bzolnier@gmail.com> <4682C87A.2040709@ru.mvista.com> <200706280010.34122.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1197 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753318AbXF2UWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 16:22:40 -0400
In-Reply-To: <200706280010.34122.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

[...]

> Damn, I should have re-check ATA specs before writing this. :)

    Yeah, never hurts... but takes time. ;-)

>>    I was thinking of checking if the drive really supports IORDY before 
>>issuing a command to set PIO mode (and just skipping the command if there's no 
>>IORDY -- well, maybe adding an extra check that the passed mode is acceptable 
>>to the drive, i.e. <= its default one).  Should be quite simple to do.

> Sounds fine.

    I'll look into doing this some time... :-)

>>>This should be done together with fixing these host drivers that don't
>>>handle IORDY properly.

>>    Erm, not necessarily...

> Hmm, yes.

> I'll just count on you with fixing all this IORDY stuff (as you have
> much more expertise in this field) and concentrate on other things.

    I'm afraid this compliment is not well deserved. :-<

>>>>>Oh yes, I keep forgetting about it - some nice FIXME comment
>>>>>in <linux/ata.h> would be of a great help. :-)

>>>>   Well, some drivers (like pdc202xx_*) don't do the IORDY thing right for 
>>>>PIO modes < 3 as well...

>>>Added to the existing IDE TODO at

>>>	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/TODO

    I think this list already needs cleaning -- e.g. at least cmd64x.c and 
hpt366.c have been deatl with.

>>>Patches adding/removing items are welcomed.

>>>Patches fixing actual issues are welcomed even more.

>>    Sigh, I'm trying to get some time (more like time slices :-) off to deal 
>>with my own issues...

    By by "my own issues" I don't mean patches -- patches don't help me, it's 
rather injections and pills... +:-)

> Which reminds me about some HPT IDE patches... 8)

    Done now -- at last. However, I've had troubles with SMPT sending them. :-/

> Bart

WBR, Sergei
