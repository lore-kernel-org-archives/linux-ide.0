From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Linux 2.6.27-rc2] suspend to disk, libata problem
Date: Fri, 8 Aug 2008 00:52:02 +0200
Message-ID: <200808080052.03443.rjw@sisk.pl>
References: <8db1092f0808071530o2f41b1b9p227dbb920e0a3961@mail.gmail.com> <alpine.LFD.1.10.0808071541150.3462@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37204 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbYHGWth (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Aug 2008 18:49:37 -0400
In-Reply-To: <alpine.LFD.1.10.0808071541150.3462@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Wilcox <matthew@wil.cx>

On Friday, 8 of August 2008, Linus Torvalds wrote:
> 
> On Fri, 8 Aug 2008, Maciej Rutecki wrote:
> >
> > I have problem with suspend to disk. On 2.6.26.* works fine.
> > 
> > During s2disk i have this messages (with "no_console_suspend" kernel option):
> > http://unixy.pl/maciek/download/kernel/2.6.27-rc2/img_0005.jpg
> > (hibernation fails)
> > 
> > Config, dmesg (normal booting):
> > http://unixy.pl/maciek/download/kernel/2.6.27-rc2/
> 
> Any chance to get this bisected? I realize that it's quite a few reboots, 
> and _maybe_ Jeff or Bartlomiej can just say "oh, duh, it's because of 
> Xyz", but the more likely thing is that without a bisect people will be 
> flailing around fairly blindly..

Looks like another incarnation of http://bugzilla.kernel.org/show_bug.cgi?id=11178

Maciej, can you try the patch at
http://bugzilla.kernel.org/attachment.cgi?id=17043&action=view
please?

Thanks,
Rafael
