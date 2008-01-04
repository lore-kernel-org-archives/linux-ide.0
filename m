From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 0/10] ide-floppy redux p1
Date: Fri, 4 Jan 2008 01:14:33 +0100
Message-ID: <200801040114.33520.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYADBT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:19:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2729247ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:19:25 -0800 (PST)
In-Reply-To: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Thursday 03 January 2008, Borislav Petkov wrote:
> 
> Hi Bart,
> 
> here's the unfinished redux of ide-floppy which i'm REsending now so that we could
> sinchronize trees. The original send got busted in vger's filters due to syntax
> error in the Message-ID tag.
> 
>  Documentation/ide/ChangeLog.ide-floppy.1996-2002 |   64 ++
>  drivers/ide/ide-floppy.c                         | 1248 +++++++---------------
>  drivers/ide/ide-floppy.h                         |  351 ++++++
>  include/linux/cdrom.h                            |    1 +
>  4 files changed, 819 insertions(+), 845 deletions(-)

I applied patch #1, patches #3, #4, #7 and #10 can be applied immediately
if you move them at the beggining of the patch series.  The rest requires
some more work but they are "almost there" (more comments in replies to
particular patches).

Thanks,
Bart
