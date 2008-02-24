From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 0/6] IDE: new series of Coding Style Fixes
Date: Sun, 24 Feb 2008 19:12:11 +0100
Message-ID: <4d8e3fd30802241012k3794882fm7f35a86b9481016f@mail.gmail.com>
References: <20080223183812.5af6d36d@paolo-desktop>
	 <200802241738.57839.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:16842 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbYBXSMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 13:12:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so486267ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 10:12:13 -0800 (PST)
In-Reply-To: <200802241738.57839.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, Feb 24, 2008 at 5:38 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>
>  On Saturday 23 February 2008, Paolo Ciarrocchi wrote:
>  > Bart,
>  > here is a new series of patches that remove some errors
>  > and warnings reported by checkpatch.pl from the IDE subsystem.
>  >
>  > All the patches have been compile tested and are against this morning (CET time :-)
>  > linux-next
>  >
>  > Paolo Ciarrocchi (6):
>  >       IDE: Coding Style fixes to drivers/ide/pci/opti621.c
>  >       IDE: Coding Style fixes to drivers/ide/legacy/hd.c
>  >       IDE: Coding Style fixes to drivers/ide/legacy/ali14xx.c
>  >       IDE: Coding Style fixes to drivers/ide/pci/it8213.c
>
>  the above change (patch 4/6) seems to be m.i.a. ?


Yes, sorry about that. I must have forgot to manually send out the patch.
I'll do that as soon as I access again to the linux box.

I really wish to be able to use git-send-mail with gmail,
unfortunatelly it's still not working
even applying all the suggestions I've got from other gmail/git users.

>  >       IDE: Coding Style fixes to drivers/ide/ide-floppy.c
>  >       IDE: Coding Style fixes to drivers/ide/pci/cmd640.c
>  >
>  >  drivers/ide/ide-floppy.c     |    4 +-
>  >  drivers/ide/legacy/ali14xx.c |   11 +++--
>  >  drivers/ide/legacy/hd.c      |   79 ++++++++++++++++++------------------
>  >  drivers/ide/pci/cmd640.c     |   90 +++++++++++++++++++++---------------------
>  >  drivers/ide/pci/it8213.c     |    9 ++--
>  >  drivers/ide/pci/opti621.c    |   50 ++++++++++++------------
>  >  6 files changed, 122 insertions(+), 121 deletions(-)
>
>  I applied all the rest (some with minor fixes).

Good. Where can I look to see the end result of our work?


Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
