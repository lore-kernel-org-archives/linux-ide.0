From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ARM: always select HAVE_IDE
Date: Sun, 27 Apr 2008 23:06:00 +0200
Message-ID: <200804272306.01052.bzolnier@gmail.com>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <200804272032.44273.bzolnier@gmail.com> <20080427202929.GB32762@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:55325 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966176AbYD1Sah (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 14:30:37 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1961297nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 11:30:33 -0700 (PDT)
In-Reply-To: <20080427202929.GB32762@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Sunday 27 April 2008, Sam Ravnborg wrote:
> > > 
> > > I do actually not care much how this gets resolved (we could even 
> > > ditch HAVE_IDE and provide asm/ide.h on all architectures) if there's 
> > > general agreement that this is the way to go.
> > 
> > Seems like a way to go now that all crazy IDE core code vs arch code
> > inter-dependiences have been fixed (the ideal solution would be to ditch
> > asm/ide.h completely but this requires some more time/work).
> 
> I invented HAVE_IDE in the past to make it trivial for arm to
> use drivers/Kconfig.
> And that incentive are not broken by your suggestion so fine with me.

Cool.

> But I really do not know about s390. They were the only one
> without IDE in the past.

They don't seem to support neither PCI nor ISA so I think that we
should just special case them (== make IDE depend on BLOCK && !S390).

Thanks,
Bart
