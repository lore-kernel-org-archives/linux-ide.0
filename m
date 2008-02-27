From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/5] ide-cd: trivial fixes
Date: Wed, 27 Feb 2008 22:18:40 +0100
Message-ID: <200802272218.40312.bzolnier@gmail.com>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:33934 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbYB0VHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 16:07:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so539700ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 13:07:14 -0800 (PST)
In-Reply-To: <1204136449-9490-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Wednesday 27 February 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are the ide-cd trivial fixes split in an easier to digest format. I
> cannot do the md5sum check here since all of the patches change at least one
> char but i hope that this'll be redundant here since they're trivially easy
> to review :) now.
> 
>  drivers/ide/ide-cd.c |  591 +++++++++++++++++++++++++-------------------------
>  1 files changed, 298 insertions(+), 293 deletions(-)

applied everything

BTW patch #3/5 which accounts for 2/3 of the diffstat passes md5sum check here
