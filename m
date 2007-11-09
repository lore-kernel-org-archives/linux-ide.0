From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/9] ide: merge flagged_taskfile() into do_rw_taskfile()
Date: Fri, 09 Nov 2007 17:02:06 +0300
Message-ID: <4734685E.8030709@ru.mvista.com>
References: <200711022305.19308.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1284 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529AbXKIOBx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 09:01:53 -0500
In-Reply-To: <200711022305.19308.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:

> Based on the earlier work by Tejun Heo.

> task->data_phase == TASKFILE_MULTI_{IN,OUT} vs drive->mult_count == 0
> check is needed also for ide_taskfile_ioctl() requests that don't have
> IDE_TFLAG_FLAGGED taskfile flag set.

> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
