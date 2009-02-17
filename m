From: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Bug #12263] Sata soft reset filling log
Date: Tue, 17 Feb 2009 11:19:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0902171102260.15234@blonde.anvils>
References: <sTyoMUwdm9B.A.QCH.U40lJB@chimera> <200902152221.43834.rjw@sisk.pl>
 <20090215223045.GC29300@elte.hu> <200902160012.57584.rjw@sisk.pl>
 <499983DF.5050503@ru.mvista.com> <49998480.3090408@ru.mvista.com>
 <499986D0.3000205@ru.mvista.com> <4999BD1A.1060101@gawab.com>
 <4999C195.5050905@ru.mvista.com> <4999DD31.4010504@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4999DD31.4010504-u1xxEuL7cY4AvxtiuMwx3w@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Justin Madru <jdm64-u1xxEuL7cY4AvxtiuMwx3w@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IDE <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 16 Feb 2009, Justin Madru wrote:
> Sergei Shtylyov wrote:
> >
> > If 12609 is truly a post-2.6.28 regression and 12263 is post-2.6.27
> > regresssion, this just cannot be.
> 
> Maybe the reporter of #12609 didn't notice/test kernels 28-rc1 to 28. Or maybe
> the difference in hardware is
> the issue, but the bug is still the same. Don't know.

Sorry Justin, you must be confused: as Sergei says,
#12609 and #12263 can only be different.

I was one of the reporters of #12609, and I do know it's a post-2.6.28
regression (and Larry said so too), and one fix (not the preferred fix)
is to revert the ata_bmdma32_port_ops from 2.6.29-rc, and the preferred
fix is to improve the ata_sff_data_xfer32() introduced in 2.6.29-rc1.

2.6.28 does not contain any ata_bmdma32_port_ops, nor ata_sff_data_xfer32(),
not did 2.6.28-rc1 contain them.  So it is impossible for the reversion of
the patch that introduced them to fix any problem on 2.6.28.

I'm quite prepared to believe that your #12263 manifests similarly to
#12609, and that a tip tree which contains a fix for #12609 contains
a fix for #12263; but please, those bugs are not the same, and they
don't have the same fix.

Hugh
