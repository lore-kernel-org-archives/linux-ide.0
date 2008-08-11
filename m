From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/22] ide: more work on generic ATAPI support
Date: Mon, 11 Aug 2008 08:36:58 +0200
Message-ID: <20080811063658.GB15436@gollum.tnic>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:33001 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYHKGhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 02:37:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so948638fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 23:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 10, 2008 at 05:35:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Just some more work on generic ATAPI layer...
> 
> - code unifications here and there
> 
> - move IDEFLOPPY_IOCTL_FORMAT_* support to a separate file
> 
> - ide_pc_intr() no longer requires zillion of arguments
> 
> Applies on top of current pata tree, tested with ide-scsi.
> 
> diffstat:
>  drivers/ide/Makefile           |    3 
>  drivers/ide/ide-atapi.c        |  323 +++++++++++++++--
>  drivers/ide/ide-floppy.c       |  739 ++++++-----------------------------------
>  drivers/ide/ide-floppy.h       |   72 +++
>  drivers/ide/ide-floppy_ioctl.c |  245 +++++++++++++
>  drivers/ide/ide-tape.c         |  396 ++++++---------------
>  drivers/scsi/ide-scsi.c        |  178 ++-------
>  include/linux/ide.h            |  266 +++++++++-----
>  8 files changed, 1035 insertions(+), 1187 deletions(-)

ACK 1-14, looks good so far. Will review the rest of them later and do some
testing.

-- 
Regards/Gruss,
    Boris.
