From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 15/15] ide: remove 'tf_in_flags' field from ide_task_t
Date: Fri, 09 Nov 2007 16:59:36 +0300
Message-ID: <473467C8.9080103@ru.mvista.com>
References: <200710310055.22468.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1261 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758614AbXKIN7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 08:59:23 -0500
In-Reply-To: <200710310055.22468.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_TFLAG_IN_DATA taskfile flag to indicate the need of reading
>   IDE_DATA_REG in ide_end_drive_cmd().

>   Set the new flag in ide_taskfile_ioctl() if ->in_flags.b.data is set.

> * Add IDE_TFLAG_FLAGGED_SET_IN_FLAGS taskfile flag to indicate the
>   need of modifying ->in_flags in ide_taskfile_ioctl().

>   Set the new flag in flagged_taskfile() and move the code modifying
>   ->tf_in_flags to ide_taskfile_ioctl().

>   While at it remove the bogus comment: ->tf_in_flags (except .b.data)
>   have no effect on selection of registers to read.

> * Remove no longer needed 'tf_in_flags' field from ide_task_t.

> As the result we finally have the internals of HDIO_DRIVE_TASKFILE ioctl
> separated from the core IDE code.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
