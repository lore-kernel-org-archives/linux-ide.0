From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.34-rc2 breaks via82cxxx Host Protected Area
Date: Sun, 28 Mar 2010 13:48:00 +0200
Message-ID: <201003281348.00697.bzolnier@gmail.com>
References: <4BAD5472.9050303@garzik.org> <201003271634.08054.bzolnier@gmail.com> <20100328140141.f4a86697.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100328140141.f4a86697.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, david@fries.net, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org


Hi Stephen,

On Sunday 28 March 2010 05:01:41 am Stephen Rothwell wrote:
> Hi Bart,
> 
> On Sat, 27 Mar 2010 16:34:08 +0100 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > On Saturday 27 March 2010 03:44:34 pm David Miller wrote:
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Date: Sat, 27 Mar 2010 11:19:53 +0100
> > > 
> > > > The commit itself may also have a problem but since it was _never_ in
> > > > linux-next tree it never saw a wider upstream testing.
> > > 
> > > This is not true Bart.
> > 
> > Uh?  I had verified my claims before writing previous mail..
> > 
> > The patch ("via82cxxx: workaround h/w bugs") appeared in Linus'
> > tree on 19th January and it was neither in next-20100101 nor in
> > next-20100119.. etc.
> 
> That commit first appeared in linux-next in next-20100120 as part of
> Dave's ide tree.  It was merged into Linus' tree on March 5th (commit
> 4c10c937cc2eb197db565392db91d429eec71176 "Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-next-2.6").

Which doesn't change a bit the fundamental fact that the patch was not
meant for upstream by me and was clearly marked as such.  If David wanted
it upstream he should either be ready to provide support for it himself
or solve it in a more formal way..

--
Bartlomiej Zolnierkiewicz
