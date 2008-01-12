From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/21] ide-floppy redux v2
Date: Sat, 12 Jan 2008 14:46:00 +0100
Message-ID: <200801121446.00276.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:50544 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762815AbYALO0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 09:26:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so610578ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 06:26:36 -0800 (PST)
In-Reply-To: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> 
> Hi Bart,
> 
>    here's the second version of the ide-floppy refactoring trail. All the
> patches are based on the version of your quilt tree from the 05.01. Also, you've
> already applied patch 5 in this series but i'm submitting it still for the sake
> of completeness.
> 
> 
>  drivers/ide/ide-cd.c     |    2 -
>  drivers/ide/ide-floppy.c | 1403 ++++++++++++++++++----------------------------
>  include/linux/cdrom.h    |    1 +
>  include/linux/ide.h      |    3 +
>  4 files changed, 558 insertions(+), 851 deletions(-)

applied patches #1-4, #8
(#4 with some changes)

#5 was already applied so I just re-ordered it into the right spot

I have some comments for #6-7
