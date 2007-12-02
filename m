From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sun, 2 Dec 2007 14:46:17 +0300
Message-ID: <20071202114617.GA2923@zarina>
References: <20071127153708.GA12490@localhost.localdomain> <4751E639.8090308@garzik.org> <20071201235810.GA2635@zarina> <20071202035755.GA3116@lixom.net>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:25172 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXLBLxc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 06:53:32 -0500
Content-Disposition: inline
In-Reply-To: <20071202035755.GA3116@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

On Sat, Dec 01, 2007 at 09:57:55PM -0600, Olof Johansson wrote:
> On Sun, Dec 02, 2007 at 02:58:10AM +0300, Anton Vorontsov wrote:
> > On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> > while (1) {
> > 	send_patches();
> > 
> > 	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
> > 		break;
> > 
> > 	sleep(wait_for_comments_timeout); <-- currently here.
> 
> I still haven't seen you address the compatible comments (that
> pata-platform is suboptimal). Or did I miss some respin of the patches?

I didn't resend these patches yet. You started the thread, but you hid
away from the discussion (you had been Cc'ed to every mail).

1. Arnd suggested {p,s}ata-pio-{1,2,3,..} or ata-{1,2,3,..} compatible
   scheme;
2. Sergei verbosely explained that that there is no reason to
   complicate compatible property. He suggested ata-generic, or
   ata-simple;

Mainly I was awaiting for your further comments. By now I tend to
follow Sergei's comments and rename compatible stuff to ata-generic.
Are you fine with it?

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
