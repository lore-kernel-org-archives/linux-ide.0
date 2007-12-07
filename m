From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/9] ide-disk: use do_rw_taskfile()
Date: Fri, 07 Dec 2007 20:19:36 +0300
Message-ID: <475980A8.1030708@ru.mvista.com>
References: <200711022305.44833.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26765 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753156AbXLGRTU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 12:19:20 -0500
In-Reply-To: <200711022305.44833.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_TFLAG_DMA_PIO_FALLBACK taskfile flag to indicate the need
>   to skip loading taskfile registers in do_rw_taskfile().

    Hm, wouldn't it be better to call this flag IDE_TFLAG_SKIP_LOADING_TF then?

> * Export do_rw_taskfile().

> * Convert __ide_do_rw_disk() to use do_rw_taskfile().

> * Unexport ide_tf_load().

> * Unexport {pre_task_out,task_in}_intr() and make it static.

> * Remove incorrect comment about do_rw_taskfile() from <linux/ide.h>.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
