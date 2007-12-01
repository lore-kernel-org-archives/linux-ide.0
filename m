From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sun, 2 Dec 2007 02:58:10 +0300
Message-ID: <20071201235810.GA2635@zarina>
References: <20071127153708.GA12490@localhost.localdomain> <4751E639.8090308@garzik.org>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:31023 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbXLBAFQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 19:05:16 -0500
Content-Disposition: inline
In-Reply-To: <4751E639.8090308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: avorontsov@ru.mvista.com, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>

On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> Anton Vorontsov wrote:
> > Hi all,
> > 
> > Here is the second spin of the OF-platform PATA driver and
> > related patches.
> > 
> > Changes since RFC:
> > - nuked drivers/ata/pata_platform.h;
> > - powerpc bits: proper localbus node added.
> > 
> > 
> > Thanks for the previous review! This time I'm collecting acks,
> > don't be shy to give 'em generously. ;-)
> if (ack_collected(PaulM))
> 	push(ACK)
> else {
> 	/* do nothing */
> }

Yep, this is obvious.

Here is the algo I'm following:

while (1) {
	send_patches();

	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
		break;

	sleep(wait_for_comments_timeout); <-- currently here.
}

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
