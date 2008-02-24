From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/6] IDE: new series of Coding Style Fixes
Date: Sun, 24 Feb 2008 17:38:57 +0100
Message-ID: <200802241738.57839.bzolnier@gmail.com>
References: <20080223183812.5af6d36d@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:31798 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYBXQcG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 11:32:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so457571ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 08:32:06 -0800 (PST)
In-Reply-To: <20080223183812.5af6d36d@paolo-desktop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>


On Saturday 23 February 2008, Paolo Ciarrocchi wrote:
> Bart,
> here is a new series of patches that remove some errors
> and warnings reported by checkpatch.pl from the IDE subsystem.
> 
> All the patches have been compile tested and are against this morning (CET time :-)
> linux-next
> 
> Paolo Ciarrocchi (6):
>       IDE: Coding Style fixes to drivers/ide/pci/opti621.c
>       IDE: Coding Style fixes to drivers/ide/legacy/hd.c
>       IDE: Coding Style fixes to drivers/ide/legacy/ali14xx.c
>       IDE: Coding Style fixes to drivers/ide/pci/it8213.c

the above change (patch 4/6) seems to be m.i.a. ?

>       IDE: Coding Style fixes to drivers/ide/ide-floppy.c
>       IDE: Coding Style fixes to drivers/ide/pci/cmd640.c
> 
>  drivers/ide/ide-floppy.c     |    4 +-
>  drivers/ide/legacy/ali14xx.c |   11 +++--
>  drivers/ide/legacy/hd.c      |   79 ++++++++++++++++++------------------
>  drivers/ide/pci/cmd640.c     |   90 +++++++++++++++++++++---------------------
>  drivers/ide/pci/it8213.c     |    9 ++--
>  drivers/ide/pci/opti621.c    |   50 ++++++++++++------------
>  6 files changed, 122 insertions(+), 121 deletions(-)

I applied all the rest (some with minor fixes).

Thanks,
Bart
