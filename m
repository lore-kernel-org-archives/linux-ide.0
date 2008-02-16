From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE cdrom problem
Date: Sat, 16 Feb 2008 18:40:08 +0100
Message-ID: <200802161840.08209.bzolnier@gmail.com>
References: <200802161624.47003.bzolnier@gmail.com> <20080216164912.GQ13446@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:12963 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbYBPR0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 12:26:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1132702fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 09:26:09 -0800 (PST)
In-Reply-To: <20080216164912.GQ13446@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: WaVeR <debian@hispeed.ch>, linux-ide@vger.kernel.org

On Saturday 16 February 2008, Borislav Petkov wrote:
> On Sat, Feb 16, 2008 at 04:24:46PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > [ added Borislav (ide-cd maintainer) to cc: ]
> > 
> > Hi,
> > 
> > Unless there are some very important reasons to keep the discussion private
> > please always cc: linux-ide@ and/or linux-kernel@ ML when reporting problems.
> > 
> > Othewise your mail misses many knowledgeable people and is left on mercy
> > of clueless IDE maintainer... ;-)
> > 
> > ----------  Forwarded Message  ----------
> > 
> > Subject: IDE cdrom problem
> > Date: Saturday 16 February 2008
> > From: WaVeR <debian@hispeed.ch>
> > To: bzolnier@gmail.com
> > 
> > Hello Bart,
> > 
> > Sorry to distrub you, but I have a similar problem like this post
> > http://lkml.org/lkml/2008/2/12/97
> > 
> > I'm not subscribed to linux ML, so I decide to write you directly.
> > 
> > 
> > >From my dmesg, I get this error:
> > 
> > Feb 16 08:01:58 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> > Feb 16 08:06:16 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> > Feb 16 08:10:45 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> > Feb 16 08:37:41 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> > Feb 16 08:42:10 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> > Feb 16 09:00:07 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> > confused (ireason = 0x01). Trying to recover by ending request.
> 
> Yeah, this is kinda funny, i think i've seen that somewhere :) But seriously,

Yep, this looks to be the identical problem as discussed recently:

http://www.mail-archive.com/linux-ide@vger.kernel.org/msg16131.html

[ + IIRC the similar issue might be already in the kernel bugzilla... ]

> can you try 2.6.25-rc2 - this one should be stable enough and it has the ide-cd
> rewrite in there and it would be interesting to see whether the new interrupt
> handler shows the same behaviour.
> 
> Bart, since this starts to occur often, i'm thinking of adding a debugging macro
> similar to the ones we rewrote in ide-floppy and ide-tape besides the
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS facility in ide-cd. What are your thoughts
> on the matter?

I would rather prefer to see more code removal/unification in ide-cd.

[ If the code is simple/clean enough and have informative printk()-s for
  error conditions there shouldn't be a frequent need for an extra debugging
  information. ]

> > As you can see on the atached file. It's a simple IDE dvdrom and a cd
> > burner.
> > 
> > I dont have this problem with the kernel 2.6.21.3
> > 
> > My actual kernel is:
> > 9:28 waver@Jupiter ~% uname -a
> > Linux Jupiter 2.6.24.2-waver.1 #1 Wed Feb 13 23:53:31 CET 2008 i686
> > GNU/Linux

It would also help us if it can be narrowed down to the specific commit.
Please install git package, get kernel git tree from kernel.org, and do:

git bisect start
git bisect good 2.6.21
git bisect bad 2.6.24

It will select the kernel to test - compile and boot it to see if the problem
is still there.  If so do "git bisect bad" which will give you new kernel
to test.  If the kernel works fine do "git bisect good" instead.  After few
iterations you should find the exact commit which introduced the bug.

Thanks,
Bart
