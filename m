From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: Optiarc DVD RW AD-7200A does play audio
Date: Sat, 4 Oct 2008 16:57:08 +0200
Message-ID: <20081004145708.GA21152@gollum.tnic>
References: <bjbMi-2A6-1@gated-at.bofh.it> <E1Km5HY-0001Yj-Gx@be1.7eggert.dyndns.org> <20081004134130.GA17429@gollum.tnic> <alpine.LSU.0.999.0810041617310.6007@be1.lrz>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:50358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbYJDO5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 10:57:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1375506fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 07:57:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.0.999.0810041617310.6007@be1.lrz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bodo Eggert <7eggert@gmx.de>, bzolnier@gmail.com
Cc: Nick Warne <nick@ukfsn.org>, linux-ide@vger.kernel.org

On Sat, Oct 04, 2008 at 04:27:25PM +0200, Bodo Eggert wrote:
> The Optiarc DVD RW AD-7200A can play audio, but tells it could not.
> 
> Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
> Test-by: Nick Warne <nick@ukfsn.org>
> X-Kernel-Version: 2.6.26

This one doesn't apply cleanly since it is against 2.6.26. Here's a current
version ontop of pata-tree:

--
From: Bodo Eggert <7eggert@gmx.de>
Subject: [PATCH] ide-cd: Optiarc DVD RW AD-7200A does play audio

The Optiarc DVD RW AD-7200A can play audio, but tells it could not.

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
Tested-by: Nick Warne <nick@ukfsn.org>
---
 drivers/ide/ide-cd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 63eada0..db87fab 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1965,6 +1965,7 @@ static const struct cd_list_entry ide_cd_quirks_list[] = {
 	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
+	{ "Optiarc DVD RW AD-7200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
