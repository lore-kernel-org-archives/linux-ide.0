From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: add CFA specific identify data words
Date: Thu, 5 Mar 2009 17:20:23 +0100
Message-ID: <200903051720.24108.bzolnier@gmail.com>
References: <20090305154040.GA23182@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:32879 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbZCEQUB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 11:20:01 -0500
In-Reply-To: <20090305154040.GA23182@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thursday 05 March 2009, Jeff Garzik wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Declare and use constants for CFA specific identify data words 162 and 163.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> 
> ---
> Sergei said:
> This patch is against the current pata-2.6 series. I'd prefer that Bart merged
> it thru his tree as my next patch adding CF mode support to IDE depends on it.
> 
> jgarzik adds:
> I didn't see this in your latest submission, Bart.  It is simple and

Simply because I haven't yet got to those patches + Sergei mentioned
that they need to be tested yet.

> harmless and might as well go ahead upstream, to eliminate the
> cross-tree dependency that Sergei speaks of (his patch also touched
> drivers/ata/libata-core.c, but I excluded that from below).

Fine with me if this makes things easier for everyone.

I updated git pull request with this patch fixing patch summary
(this is not libata specific change) and patch description (constants
are not currently unused) while at it.

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ata: add CFA specific identify data words

Declare CFA specific identify data words 162 and 163 for future use.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
[bart: update patch summary/description]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ata.h       |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h
+++ linux-2.6/include/linux/ata.h
@@ -89,6 +89,8 @@ enum {
 	ATA_ID_DLF		= 128,
 	ATA_ID_CSFO		= 129,
 	ATA_ID_CFA_POWER	= 160,
+	ATA_ID_CFA_KEY_MGMT	= 162,
+	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
