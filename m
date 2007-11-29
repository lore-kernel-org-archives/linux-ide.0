From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/15] ide: remove 'command_type' field from ide_task_t
Date: Thu, 29 Nov 2007 19:47:58 +0300
Message-ID: <474EED3E.4030404@ru.mvista.com>
References: <200710310055.17380.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3463 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751882AbXK2Qrr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:47:47 -0500
In-Reply-To: <200710310055.17380.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add 'data_buf' and 'nsect' variables in ide_taskfile_ioctl()
>   to cache data buffer pointer and number of sectors to transfer
>   (this allows us to have only one ide_diag_taskfile() call).

> * Add IDE_TFLAG_WRITE taskfile flag and use it to check whether
>   the REQ_RW request flag should be set.

> * Move ->command_type handling from ide_diag_taskfile() to
>   ide_taskfile_ioctl() and use ->req_cmd instead of ->command_type.

> * Add 'nsect' parameter to ide_raw_taskfile().

> * Merge ide_diag_taskfile() into ide_raw_taskfile().

> * Initialize ->data_phase explicitly in idedisk_prepare_flush(),
>   ide_start_power_step() and ide_disk_special().

> * Remove no longer needed 'command_type' field from ide_task_t.

> * Add #ifndef/#endif __KERNEL__ to <linux/hdreg.h> around no
>   longer used by kernel IDE_DRIVE_TASK_* and TASKFILE_* defines.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
