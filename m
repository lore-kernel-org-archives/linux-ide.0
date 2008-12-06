From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/6] ide-cd: move cdrom_timer_expiry to ide-atapi.c
Date: Sat, 6 Dec 2008 15:51:24 +0100
Message-ID: <200812061551.24745.bzolnier@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com> <1228373010-20249-6-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:48264 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbYLFOyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Dec 2008 09:54:47 -0500
Received: by mu-out-0910.google.com with SMTP id g7so409347muf.1
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 06:54:45 -0800 (PST)
In-Reply-To: <1228373010-20249-6-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>


On Thursday 04 December 2008, Borislav Petkov wrote:
> - cdrom_timer_expiry -> ide_cd_expiry
> - remove expiry-arg to ide_issue_pc as it is redundant now
> 
> There should be no functionality change resulting from this patch.

Well, there is a minor change actually: ide_debug_log -> debug_log.

> @@ -250,7 +251,38 @@ int ide_scsi_expiry(ide_drive_t *drive)
>  
>  	return 0; /* we do not want the IDE subsystem to retry */
>  }
> -EXPORT_SYMBOL_GPL(ide_scsi_expiry);

This seems to remove the symbol accidentally and although I've
just applied patch doing scheduled ide-scsi removal it would be
much better to take care of the core code's ide-scsi remnants
in separate patch(es).

> @@ -19,7 +19,6 @@
>  /*
>   * typical timeout for packet command
>   */
> -#define ATAPI_WAIT_PC		(60 * HZ)
>  #define ATAPI_WAIT_WRITE_BUSY	(10 * HZ)

The comment should be moved together with ATAPI_WAIT_PC define
(or removed).

The rest of the patch is fine.
