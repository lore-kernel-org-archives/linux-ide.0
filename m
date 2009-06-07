From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 21:23:05 +0200
Message-ID: <200906072123.05999.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <200906071947.19723.bzolnier@gmail.com> <1244401729.8262.102.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:63737 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZFGTUs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 15:20:48 -0400
In-Reply-To: <1244401729.8262.102.camel@mulgrave.site>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 21:08:49 James Bottomley wrote:
> On Sun, 2009-06-07 at 19:47 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 07 June 2009 18:08:09 James Bottomley wrote:
> > > So I have two specific problems with the way you're trying to one up
> > > libata:
> > > 
> > >      1. You're trying to get a jump on them by adding features as bug
> > >         fixes ... this is incredibly bad release practice.
> > 
> > It is a bugfix.  Long overdue one.
> 
> > However you have to look beyond kernel to see it.  From the commit log:
> > 
> > "
> > From the perspective of most users of recent systems, disabling Host
> > Protected Area (HPA) can break vendor RAID formats, GPT partitions and
> > risks corrupting firmware or overwriting vendor system recovery tools.
> > 
> > Unfortunately the original (kernels < 2.6.30) behavior (unconditionally
> > disabling HPA and using full disk capacity) was introduced at the time
> > when the main use of HPA was to make the drive look small enough for the
> > BIOS to allow the system to boot with large capacity drives.
> > 
> > Thus to allow the maximum compatibility with the existing setups (using
> > HPA and partitioned with HPA disabled) we automically disable HPA if
> > any partitions overlapping HPA are detected.  Additionally HPA can also
> > be disabled using the "nohpa" module parameter (i.e. "ide_core.nohpa=0.0"
> > to disable HPA on /dev/hda).
> > "
> > 
> > Yes, it is true that there is no rush.
> 
> So why 2.6.30-rc7 then?
> 
> > OTOH there are absolutely no valid technical reasons to slow it down!
> 
> There is incredibly valid reason not to put this in 2.6.30-rc7: You've
> added a feature (HPA) which ide previously ignored, so now you need to

No.  HPA as feature was always supported back to 2.4.x days.

End of discussion.  I'm not even reading the rest of your mail.

Please go read the code and don't come back till you do.
