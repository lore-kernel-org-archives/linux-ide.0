From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Use on-board instead of built-in in config options
Date: Fri, 1 Feb 2008 22:49:22 +0100
Message-ID: <200802012249.22848.bzolnier@gmail.com>
References: <200801262043.17739.bzolnier@gmail.com> <200801262208.28859.bzolnier@gmail.com> <200801271620.01629.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:50691 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbYBAWhD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so945371wah.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:02 -0800 (PST)
In-Reply-To: <200801271620.01629.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Sunday 27 January 2008, Frans Pop wrote:
> On Saturday 26 January 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 26 January 2008, Jan Engelhardt wrote:
> > > On Jan 26 2008 21:31, Frans Pop wrote:
> > > >>  config BLK_DEV_IDE_PMAC
> > > >> -       bool "Builtin PowerMac IDE support"
> > > >> +       tristate "Builtin PowerMac IDE support"
> >
> > this change is no-op at the moment because the next Kconfig line is:
> >
> > 	depends on PPC_PMAC && IDE=y && BLK_DEV_IDE=y
> >
> > [ PPC-specific IDE host drivers are still a special case because they are
> >   using ppc_ide_md architecture hooks instead of doing proper host driver
> >   initialization sequence - to be fixed after adding warm-plug support...
> > ]
> >
> > > >This does not seem to make sense: if the option is now tristate, it is
> > > > no longer "Builtin", so probably s/Builtin // in the description.
> > >
> > > Or something like s/Builtin/Onboard/;
> 
> I did not even consider that meaning of built-in, but that does seem more 
> descriptive.
> 
> > Please send a patch.
> 
> Of course :-)
> 
> ---
> From: Frans Pop <elendil@planet.nl>
> 
> To avoid confusion between 'built-in' drivers and 'on-board'
> controllers, consistently use the term 'on-board' for controllers.
> 
> Minor line-wrapping improvements in descriptions for config options.
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>

applied, thanks
