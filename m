From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.34-rc2 breaks via82cxxx Host Protected Area
Date: Sat, 27 Mar 2010 16:34:08 +0100
Message-ID: <201003271634.08054.bzolnier@gmail.com>
References: <4BAD5472.9050303@garzik.org> <201003271119.53757.bzolnier@gmail.com> <20100327.074434.193717071.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:64734 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab0C0PfR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2010 11:35:17 -0400
In-Reply-To: <20100327.074434.193717071.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: david@fries.net, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Saturday 27 March 2010 03:44:34 pm David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Sat, 27 Mar 2010 11:19:53 +0100
> 
> > The commit itself may also have a problem but since it was _never_ in
> > linux-next tree it never saw a wider upstream testing.
> 
> This is not true Bart.

Uh?  I had verified my claims before writing previous mail..

The patch ("via82cxxx: workaround h/w bugs") appeared in Linus'
tree on 19th January and it was neither in next-20100101 nor in
next-20100119.. etc.

Why?  I have no idea..  I've just noticed it today..

> My ide-2.6 and ide-next-2.6 trees are both included in
> linux-next   And if they are not, that needs to be fixed
> because they very much are intended to be.

Not my area of responsibility..

> In any event, you wrote a patch which broke something and
> if you're not willing to work on a fix I have no choice
> but to simply revert.

Please..

You picked a patch out of larger patch series posted to a mailing
list (which was clearly marked as a one for my atang tree and not
for upstream), then you merged it adding your sign-off, did poor
job w.r.t. linux-next testing phase and now I'm the one to blame
for the breakage? :)

Well, your stance on kernel project management has been already
made crystal clear during rt28xx driver discussions so I'm not
really surprised here.  I also don't remember ever signing support
contract with you or your employer so I will be putting your mails
into a separate folder (lets call it 'almost-spam') from now on..

--
Bartlomiej Zolnierkiewicz
