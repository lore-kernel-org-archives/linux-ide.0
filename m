From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Sat, 24 Oct 2009 14:38:00 +0200
Message-ID: <200910241438.00739.bzolnier@gmail.com>
References: <4AE1E78A.2090801@ru.mvista.com> <200910232052.47860.bzolnier@gmail.com> <20091023.202447.165598626.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58214 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZJXMkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 08:40:18 -0400
Received: by fxm18 with SMTP id 18so10976085fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2009 05:40:21 -0700 (PDT)
In-Reply-To: <20091023.202447.165598626.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, sshtylyov@ru.mvista.com, mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

On Saturday 24 October 2009 05:24:47 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Fri, 23 Oct 2009 20:52:47 +0200
> 
> > "Old" one corrupts because somebody thought it would be a smart move
> > to remove serialized flag instead of debugging certain problem
> > properly..
> 
> Bart, I fear you may live your entire life always with some
> axe to grind with someone.
> 
> It makes it impossible to work with you effectively.

You mean that I don't enjoy the idea of "just a managers" trying to
"manage" my free time?  Well, I don't.

I also don't buy the definition of "working with" presented by you.

> I've tried to start taking the personal attacks out of my
> interactions with you, but you seem to be completely unable
> to drop it.
> 
> If you're constantly bitter about this or that, nobody will
> want to work with you.

I'm not bitter, I just stick to the facts.

My mails may sound rude sometimes but they _always_ have the backing
in facts (and if I'm wrong I have no problem with saying "sorry, I was
wrong").

If you want to see how (unprovoked) personal attacks look like please
go re-read your own mails from few months ago...

It is all here:

	http://patchwork.ozlabs.org/patch/28945/

Please start with:

| Unlike the commit log message states, I suspect this change
| "introduces" incorrect handling of unexpected IRQs rather than
| "fixing".  I suspect the problem arises when the controller

and

| That's why all the IDE drivers are constantly breaking on sparc.

parts.
