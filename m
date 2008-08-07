From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Linux 2.6.27-rc2] suspend to disk, libata problem
Date: Thu, 7 Aug 2008 15:55:41 -0700
Message-ID: <200808071555.42088.jbarnes@virtuousgeek.org>
References: <8db1092f0808071530o2f41b1b9p227dbb920e0a3961@mail.gmail.com> <alpine.LFD.1.10.0808071541150.3462@nehalem.linux-foundation.org> <200808080052.03443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758028AbYHGW4U@vger.kernel.org>
In-Reply-To: <200808080052.03443.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-ide@vger.kernel.org

On Thursday, August 7, 2008 3:52 pm Rafael J. Wysocki wrote:
> On Friday, 8 of August 2008, Linus Torvalds wrote:
> > On Fri, 8 Aug 2008, Maciej Rutecki wrote:
> > > I have problem with suspend to disk. On 2.6.26.* works fine.
> > >
> > > During s2disk i have this messages (with "no_console_suspend" kernel
> > > option): http://unixy.pl/maciek/download/kernel/2.6.27-rc2/img_0005.jpg
> > > (hibernation fails)
> > >
> > > Config, dmesg (normal booting):
> > > http://unixy.pl/maciek/download/kernel/2.6.27-rc2/
> >
> > Any chance to get this bisected? I realize that it's quite a few reboots,
> > and _maybe_ Jeff or Bartlomiej can just say "oh, duh, it's because of
> > Xyz", but the more likely thing is that without a bisect people will be
> > flailing around fairly blindly..
>
> Looks like another incarnation of
> http://bugzilla.kernel.org/show_bug.cgi?id=11178
>
> Maciej, can you try the patch at
> http://bugzilla.kernel.org/attachment.cgi?id=17043&action=view
> please?

I just pushed this fix into my for-linus tree.  I wanted it (along with the 
rest of my for-linus stuff) to get one day in linux-next before asking Linus 
to pull it though...

Jesse
