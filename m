From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] optical /proc/ide/*/media
Date: Thu, 7 Sep 2006 15:08:46 +0400
Message-ID: <20060907110846.GB5470@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:11164 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751657AbWIGLIv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Sep 2006 07:08:51 -0400
Received: by nf-out-0910.google.com with SMTP id o25so417338nfa
        for <linux-ide@vger.kernel.org>; Thu, 07 Sep 2006 04:08:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Sergey Vlasov reported that his "FUJITSU MCC3064AP, ATAPI OPTICAL drive"
pops up as UNKNOWN in /proc/ide/*/media .

Closes #4145.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/ide-proc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -376,6 +376,8 @@ static int proc_ide_read_media
 				break;
 		case ide_floppy:media = "floppy\n";
 				break;
+		case ide_optical:media = "optical\n";
+				break;
 		default:	media = "UNKNOWN\n";
 				break;
 	}

