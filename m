From: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 05 Jan 2004 17:48:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1073321295.7121.8.camel@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401032302.32914.bzolnier@elka.pw.edu.pl>
	 <1073237458.6069.31.camel@leto.cs.pocnet.net>
	 <200401051712.41695.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:2237 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265163AbUAEQs3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2004 11:48:29 -0500
In-Reply-To: <200401051712.41695.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Am Mo, den 05.01.2004 schrieb Bartlomiej Zolnierkiewicz um 17:12:

> > The IDE_TASKFILE_IO gets things right (from my point of view) and is
> > also much cleaner. (I would personally vote for dropping the non
> > TASKFILE_IO code, it would make my problem go away :D - why is it still
> > marked as experimental BTW? I've been using it since it was introduced,
> > without any problems)
> 
> There are still some issues to be resolved:
> - hangs during reading /proc/ide/<cdrom>/identify on some drives
>   (workaround is now known thanks to debugging done by Andi+BenH+Andre)
> - unexplained fs corruption on x86-64 with AMD IDE chipsets
>   (the real showstopper)
> - somebody needs to test taskfile code on old Promise PDC4030 controller
>   (low priority)

Unexplained corruptions. Coder's nightmare. ;) Yes, that's always really
bad. Unfortunately I don't have such a machine so I can't help trying to
nail it down.

> > Perhaps I can think of something else. It's really tricky...
> 
> I would like to remove non CONFIG_IDE_TASKFILE_IO paths in 2.6.x
> (after issues are resolved) instead of trying to fix them.

Sure, we agree on that point. I think everyone does.

BTW, I've found a not too complicated workaround for my particular
original problem so the bi_idx issue isn't a showstopper for my
device-mapper target. But apart from that the rewinding bi_idx to zero
thing still gives me headaches just being there. A small non-invasive
workaround won't make it much worse, it's hopefully going to die anyway.

Thanks for being patient with me. :-)
(and not raising new paranoia theories ;-))


