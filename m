From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/9] ide: use ->data_phase to set ->handler in do_rw_taskfile()
Date: Mon, 12 Nov 2007 19:12:39 +0300
Message-ID: <47387B77.1010805@ru.mvista.com>
References: <200711022305.30663.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:21458 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751578AbXKLQM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 11:12:28 -0500
In-Reply-To: <200711022305.30663.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use ->data_phase to set ->handler in do_rw_taskfile() instead of
>   setting ->handler in callers of ide_raw_taskfile()/do_rw_taskfile().

> * Unexport task_no_data_intr() and make it static.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
