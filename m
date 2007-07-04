From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Wed, 04 Jul 2007 20:33:15 +0400
Message-ID: <468BCBCB.30308@ru.mvista.com>
References: <200706232005.10968.bzolnier@gmail.com> <200706280010.34122.bzolnier@gmail.com> <46856A77.9050808@ru.mvista.com> <200706300016.34267.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32445 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751500AbXGDQbT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 12:31:19 -0400
In-Reply-To: <200706300016.34267.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>   I was thinking of checking if the drive really supports IORDY before 
>>>>issuing a command to set PIO mode (and just skipping the command if there's no 
>>>>IORDY -- well, maybe adding an extra check that the passed mode is acceptable 
>>>>to the drive, i.e. <= its default one).  Should be quite simple to do.

>>>Sounds fine.

>>    I'll look into doing this some time... :-)

> Cool.

    Unfortunately, got assigned to an urgent bug... been trying to pass it 
along but not much hope on this. :-/

>>>>>Patches adding/removing items are welcomed.

>>>>>Patches fixing actual issues are welcomed even more.

>>>>   Sigh, I'm trying to get some time (more like time slices :-) off to deal 
>>>>with my own issues...

>>    By by "my own issues" I don't mean patches -- patches don't help me, it's 
>>rather injections and pills... +:-)

> Heh, sorry I didn't know about that.

> I hope that it is nothing serious and wish you quick recovery...

    From diabetes? Not bloody likely. :-D

> So you could hack some more... :-)

    That's why I now have to fix at least some consequencies (also of a hard 
hacking :-)

MBR, Sergei
