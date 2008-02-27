From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/5] ide-cd: trivial fixes
Date: Wed, 27 Feb 2008 19:20:44 +0100
Message-ID: <1204136449-9490-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:42242 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbYB0SVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 13:21:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1561716nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 10:21:20 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are the ide-cd trivial fixes split in an easier to digest format. I
cannot do the md5sum check here since all of the patches change at least one
char but i hope that this'll be redundant here since they're trivially easy
to review :) now.

 drivers/ide/ide-cd.c |  591 +++++++++++++++++++++++++-------------------------
 1 files changed, 298 insertions(+), 293 deletions(-)

Thanks,
Boris.
