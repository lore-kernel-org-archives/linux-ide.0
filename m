From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/5] ide debugging macros
Date: Mon, 18 Aug 2008 23:29:13 +0200
Message-ID: <200808182329.13199.bzolnier@gmail.com>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com> <200808182308.38345.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30853 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbYHRVcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 17:32:11 -0400
Received: by gv-out-0910.google.com with SMTP id e6so601338gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 18 Aug 2008 14:32:10 -0700 (PDT)
In-Reply-To: <200808182308.38345.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 18 August 2008, Bartlomiej Zolnierkiewicz wrote:
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

Together with sysfs device-driver binding/unbinding support it
can probably substitute for lack of sysfs attribute for now. ;)

Anyway adding a proper device sysfs attribute will be trivial
(ide_dev_attrs[]) but lets wait with it until things settle down.

Thanks,
Bart
