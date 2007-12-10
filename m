From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 17/20] ide: fix final status check in drive_cmd_intr()
Date: Mon, 10 Dec 2007 16:44:40 +0300
Message-ID: <475D42C8.7010802@ru.mvista.com>
References: <200712092219.55175.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48458 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751726AbXLJNoU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 08:44:20 -0500
In-Reply-To: <200712092219.55175.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Don't check for READY_STAT bit being set for PIO-in protocol (makes the
> final status check in drive_cmd_intr() match the one in task_in_intr()).

> Also fix function name reported by ide_error() call while at it.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
