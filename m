From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/9] ide: convert do_rw_taskfile() to use ->data_phase
Date: Fri, 09 Nov 2007 20:40:57 +0300
Message-ID: <47349BA9.20206@ru.mvista.com>
References: <200711022305.27131.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2231 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754195AbXKIRkp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 12:40:45 -0500
In-Reply-To: <200711022305.27131.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use task->data_phase in do_rw_taskfile() to decide what to do.

> * task->prehandler is only used by TASKFILE[_MULTI]_OUT so just
>   use pre_task_out_intr() directly and remove no longer needed
>   'prehandler' field from ide_task_t.

> * Remove no longer needed ide_pre_handler_t type.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
