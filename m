From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Build fix for CONFIG_IDE_PROC_FS=n
Date: Sun, 31 Aug 2008 17:52:05 +0200
Message-ID: <200808311752.06818.bzolnier@gmail.com>
References: <20080829213217.4826.91622.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:29534 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYHaQLJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2008 12:11:09 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1603239muf.1
        for <linux-ide@vger.kernel.org>; Sun, 31 Aug 2008 09:11:07 -0700 (PDT)
In-Reply-To: <20080829213217.4826.91622.stgit@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 29 August 2008, Elias Oltmanns wrote:
> Recent changes have broken compilation when CONFIG_IDE_PROC_FS is not set.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

Thanks!

I integrated your fixes into guilty patches ("ide-floppy: move /proc handling
to ide-floppy_proc.c" and "ide-disk: move /proc handling to ide-disk_proc.c")
to preserve bisection.
