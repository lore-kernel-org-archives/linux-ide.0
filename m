From: Sven Riedel <sr@gimp.org>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Sun, 16 Jul 2006 09:13:38 +0200
Message-ID: <20060716071338.GA12932@localnet>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca> <44B7D4E4.4000607@rtr.ca> <20060715065001.GA11832@localnet> <44B8E8D6.8020903@rtr.ca> <20060715132012.GA18761@localnet> <87f94c370607150631g6f91d6fav511cdd8411b39af5@mail.gmail.com>
Reply-To: sr@gimp.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kamp-dsl.de ([195.62.99.42]:60310 "HELO
	mailout.kamp-dsl.de") by vger.kernel.org with SMTP id S1750710AbWGPRqA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Jul 2006 13:46:00 -0400
Received: from dsl-mail.kamp.net (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with SMTP
	id 110C7871CBF1-0
	for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 17:45:59 +0000
Received: from mx01.kamp-dsl.de (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with ESMTP
	id 110C7871CB79-0
	for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 17:45:58 +0000
Content-Disposition: inline
In-Reply-To: <87f94c370607150631g6f91d6fav511cdd8411b39af5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: sr@gimp.org, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Sat, Jul 15, 2006 at 09:31:01AM -0400, Greg Freemyer wrote:
> On 7/15/06, Sven Riedel <sr@gimp.org> wrote:
> >Ok. Well, since I can duplicate the exact same error here consistently, 
> >I'll
> >grab 2.6.18rc1 and report back if I can reproduce the error there or not.
> >
> If you don't want to try the whole 2.6.18.rc1 kernel, the new EH is
> available as a big patch for 2.6.17
> 

Well, I got the 2.6.18rc1 kernel and found that I could copy three times the
amount of data onto the array without triggering the error message. So it
looks like that bug got squashed.

OTOH, reading more than a few megabytes from an LVM logical volume crashed the
computer so hard, it didn't even have time to throw out a kernel panic (I
don't have a serial console, so I don't know about that. And I realize LVM
stuff is a different mailinglist, just a heads up for people who want to grab
the rc1 tree and run with it - try the patch instead).

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
