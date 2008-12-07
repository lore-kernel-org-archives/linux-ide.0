From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/4] ide: remove ide-scsi remnants
Date: Sun, 7 Dec 2008 19:43:16 +0100
Message-ID: <20081207184316.GA30260@gollum.tnic>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:9257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYLGSnS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 13:43:18 -0500
Received: by mu-out-0910.google.com with SMTP id g7so803278muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 10:43:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Dec 07, 2008 at 06:21:07PM +0100, Borislav Petkov wrote:
> Hi Bart,
> 
> here are the patches removing bits and pieces belonging to the late ide-scsi :).
> 

here's the correct (and not reversed :)) diffstat though:

 drivers/ide/ide-atapi.c  |   97 +++++++++-------------------------------------
 drivers/ide/ide-io.c     |    3 -
 drivers/ide/ide-ioctls.c |    3 +-
 drivers/ide/ide-probe.c  |    2 -
 include/linux/ide.h      |   34 ++++++----------
 5 files changed, 33 insertions(+), 106 deletions(-)

-- 
Regards/Gruss,
    Boris.
