From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/10] ide-cd: use generic ide_issue_pc
Date: Mon, 15 Sep 2008 20:30:50 +0200
Message-ID: <200809152030.51074.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:5749 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbYIOScR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:32:17 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2270292rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:32:17 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Sunday 14 September 2008 13:35:48 Borislav Petkov wrote:
> Hi Bart,
> 
> here are some patches converting ide-cd to using ide_issue_pc. Next is
> replacing cdrom_transfer_packet_command with ide_transfer_pc.
> 
>  drivers/ide/ide-atapi.c  |   71 ++++++++++++++++++++++---------
>  drivers/ide/ide-cd.c     |  104 ++++++---------------------------------------
>  drivers/ide/ide-cd.h     |   30 +++++++++++++-
>  drivers/ide/ide-floppy.c |    2 +-
>  drivers/ide/ide-tape.c   |    2 +-
>  drivers/scsi/ide-scsi.c  |    3 +-
>  include/linux/ide.h      |    5 ++-
>  7 files changed, 102 insertions(+), 115 deletions(-)

Thanks for finding time to work on this.  Overall it looks good
and I applied some patches already (#1/2/4) but the rest would
need some final recasting/polishing before they can go in (please
see the individual replies for details).

Bart
