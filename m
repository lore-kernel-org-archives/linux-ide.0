From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/5] ide debugging macros
Date: Tue, 19 Aug 2008 08:23:17 +0200
Message-ID: <20080819062317.GB30315@gollum.tnic>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com> <200808182308.38345.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:31652 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYHSGXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 02:23:14 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2402771fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 18 Aug 2008 23:23:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808182308.38345.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Aug 18, 2008 at 11:08:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Sunday 17 August 2008, Borislav Petkov wrote:
> > Hi Bart,
> > 
> > here's something i've been wanting to do for a long time: debugging macros. The
> > reason for it is that i got tired of adding debug printk's everytime i'm testing
> > something so here we go.
> > 
> > The debugging macro is similar to the old ones but is one for all drivers
> > (currently only ide-floppy), is nice on branch prediction and is controlled by a
> > drive->debug_mask switch which is a module parameter and as such can be set at
> > module load time, of course. I've been thinking of adding also a sysfs attribute
> > too but can't seem to find quite the justification for it so no sysfs for now :)
> 
> if you look closely you should already find it :)
> 
> [ module parameters are exported through sysfs and it uses 0644 mask ]

Aah, i get it now, it's /sys/bus/ide/drivers/ide-floppy/module/parameters/debug_mask.
However, it'd be better if it were /sys/bus/ide/drivers/ide-floppy/debug_mask.
Probably a symlink or a true /sysfs parameter? Maybe later :).

-- 
Regards/Gruss,
    Boris.
