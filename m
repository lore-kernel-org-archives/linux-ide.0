From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] swarm: use struct ide_port_info
Date: Tue, 10 Jun 2008 19:36:22 +0200
Message-ID: <200806101936.23181.bzolnier@gmail.com>
References: <200806082010.35429.bzolnier@gmail.com> <Pine.LNX.4.55.0806081934090.15673@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:26534 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbYFJTPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 15:15:45 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1893375mue.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 12:15:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.55.0806081934090.15673@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 08 June 2008, Maciej W. Rozycki wrote:
> On Sun, 8 Jun 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> > Convert the driver to use struct ide_port_info.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Cc: Maciej W. Rozycki <macro@linux-mips.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> 
> Acked-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
>  Verified to work correctly on my system, thanks.

Thanks, I added Acked-by: + Tested-by: to the patch.

> > +	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
> 
>  You could have saved one <Tab> here. ;)

Well, yes but it matches other host drivers (which need two <Tab>s). :)

Bart
