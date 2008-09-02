From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Build fix for CONFIG_IDE_PROC_FS=n
Date: Tue, 2 Sep 2008 12:35:36 +0200
Message-ID: <200809021235.36429.bzolnier@gmail.com>
References: <20080829213217.4826.91622.stgit@denkblock.local> <200808311752.06818.bzolnier@gmail.com> <878wub1nso.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:48077 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYIBKoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 06:44:24 -0400
Received: by ik-out-1112.google.com with SMTP id c28so973122ika.5
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 03:44:23 -0700 (PDT)
In-Reply-To: <878wub1nso.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 September 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On Friday 29 August 2008, Elias Oltmanns wrote:
> >> Recent changes have broken compilation when CONFIG_IDE_PROC_FS is not set.
> >> 
> >> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> >
> > Thanks!
> >
> > I integrated your fixes into guilty patches ("ide-floppy: move /proc handling
> > to ide-floppy_proc.c" and "ide-disk: move /proc handling to ide-disk_proc.c")
> > to preserve bisection.
> 
> Yes, that's fine with me, but in the case of ide-disk_proc.h things
> apparently went wrong. As of next-20080901, I still have the line
> 
> ide-disk_mod-y += ide-disk.o ide-disk_ioctl.o ide-disk_proc.o
> 
> in the Makefile. Could you please truncate that line appropriately?

Fixed, thanks for noticing.
