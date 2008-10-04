From: Bodo Eggert <7eggert@gmx.de>
Subject: [PATCH] ide-cd: Optiarc DVD RW AD-7200A does play audio
Date: Sat, 4 Oct 2008 16:27:25 +0200 (CEST)
Message-ID: <alpine.LSU.0.999.0810041617310.6007@be1.lrz>
References: <bjbMi-2A6-1@gated-at.bofh.it> <E1Km5HY-0001Yj-Gx@be1.7eggert.dyndns.org>
 <20081004134130.GA17429@gollum.tnic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:58904 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865AbYJDORN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 10:17:13 -0400
In-Reply-To: <20081004134130.GA17429@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bodo Eggert <7eggert@gmx.de>, Nick Warne <nick@ukfsn.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com

The Optiarc DVD RW AD-7200A can play audio, but tells it could not.

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
Test-by: Nick Warne <nick@ukfsn.org>
X-Kernel-Version: 2.6.26

--- linux-2.6.26/drivers/ide/ide-cd.c.ori	2008-10-04 13:21:17.000000000 +0200
+++ linux-2.6.26/drivers/ide/ide-cd.c	2008-10-04 13:22:15.000000000 +0200
@@ -1842,6 +1842,7 @@ static const struct cd_list_entry ide_cd
 	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
 	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
 	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
+	{ "Optiarc DVD RW AD-7200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
 	{ NULL, NULL, 0 }
 };
 
-- 
Funny quotes:
15. I drive way too fast to worry about cholesterol.
