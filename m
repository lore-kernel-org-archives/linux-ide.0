From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Mon, 20 Apr 2009 23:01:33 +0200
Message-ID: <200904202301.34166.bzolnier@gmail.com>
References: <200903222223.10572.marek.vasut@gmail.com> <200904202238.39229.bzolnier@gmail.com> <200904202253.06559.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37108 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZDTU5R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Apr 2009 16:57:17 -0400
Received: by fxm2 with SMTP id 2so2193173fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2009 13:57:15 -0700 (PDT)
In-Reply-To: <200904202253.06559.marek.vasut@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Monday 20 April 2009 22:53:06 Marek Vasut wrote:
> On Monday 20 of April 2009 22:38:38 Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 19 April 2009 18:14:05 Marek Vasut wrote:
> > > On Sunday 22 of March 2009 22:23:10 Marek Vasut wrote:
> > > > > Dne Saturday 16 of August 2008 11:08:03 Russell King - ARM Linux
> > >
> > > napsal(a):
> > > > > > On Wed, Aug 13, 2008 at 10:52:23PM +0200, Marek Vasut wrote:
> > > > > > > This patch adds palmld ide channel support, same as previous
> > > > > > > patch, I think this can be merged since it wont break anything.
> > > > > >
> > > > > > I think this one also needs review by the Linux ATA folk.  Mention
> > > > > > to them that it's part of a patchset for ARM and that you'd prefer
> > > > > > it to be merged into the ARM tree.
> > > > > >
> > > > > > > +static const char drvname[] = "pata_palmld";
> > > > > > > +MODULE_ALIAS("platform: "drvname);
> > > > > >
> > > > > > Have you tried building this as a module?  Also, IIRC, there isn't
> > > > > > supposed to be a space after the colon...
> > > > >
> > > > > Ok, I fixed the issues and CCed linux-ide and the maintainer.
> > > > >
> > > > > Thanks
> > > >
> > > > Hi, Im resending this patch since it was totally ignored last time. It
> > > > still applies correctly. It'd be for the best to push this through
> > > > arm-kernel tree.
> > > >
> > > > Best regards
> > > > Marek Vasut
> > >
> > > It's still being totally ignored on both mailing lists ... why? Thanks
> >
> > I don't know the answer for your question but this patch is not for me.
> >
> > Please take me off cc: list unless you're also going to submit *IDE* driver
> > (sorry, I have no time to review libata patches).  Thanks.
> 
> That's good to know, where should I send it then? Thanks

see Cc: :)
