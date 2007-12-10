From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/20] ide: initialize rq->cmd_type in ide_init_drive_cmd()
 callers
Date: Mon, 10 Dec 2007 16:03:56 +0300
Message-ID: <475D393C.9010604@ru.mvista.com>
References: <200712092216.50738.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48117 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751805AbXLJNDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 08:03:36 -0500
In-Reply-To: <200712092216.50738.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Initialize rq->cmd_type in ide_wait_cmd(), ide_cmd_ioctl() and
>   set_pio_mode() (other callers were aleady over-riding rq->cmd_type).

> * Remove no longer needed rq->cmd_type setup from ide_init_drive_cmd().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Despite the patch hardly seems necessary to me

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
