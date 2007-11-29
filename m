From: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Wed, 28 Nov 2007 23:17:57 -0300 (ART)
Message-ID: <21360.16619.qm@web56311.mail.re3.yahoo.com>
References: <474E1012.40703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web56311.mail.re3.yahoo.com ([216.252.110.235]:38013 "HELO
	web56311.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756317AbXK2CR7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 21:17:59 -0500
In-Reply-To: <474E1012.40703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, hmh@debian.org

Hi,

> 2.6.22 fixes the problem completely for distros
> which don't issue spin
> down.  For distros which do issue spin down, the
> situation isn't worse,
> the kernel behaves the same way as before 2.6.22.=20
> It just issues
> FLUSH_CACHE.  The warning message is for small
> fraction of disks
> mentioned above which do double spin down and to
> accelerate transition
> to kernel-driven spin down.

What you're telling me contradicts my experience.
I'm using Debian Etch with my custom kernel 2.6.23
After seeing debian's code, shutdown does NOT issue
spin down in my friend's pc. The clack sounds, and the
warning appears.
Using patched code, I don't have any more clacks and
warnings. After seeing the altered code, shutdown now
IS spinning down the sda.
However none of them is flushing the cache as you
suggests.

So you're saying:
1) Don't spin down to avoid the problem
2) Flush cache solves the problem

I'm seeing:
1) The hdd is not spun down by shutdown and the
problem persists
2) By spinning down /dev/sdX in shutdown(8) the
problem disappears. Flush cache doesn't seem to
influence the emergency shutdown problem.

That's why I'm confused.
May be I've missed something in the code.

> So, the patch isn't in the package yet?

I checked yesterday both Debian's unstable and
testing, and the patch wasn't there.

Dark Sylinc


      Compart=ED video en la ventana de tus mensajes (y tambi=E9n tus f=
otos de Flickr).=20
Us=E1 el nuevo Yahoo! Messenger versi=F3n Beta. http://ar.beta.messenge=
r.yahoo.com/
