From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/9] ide-disk: add ide_tf_set_cmd() helper
Date: Mon, 12 Nov 2007 19:17:52 +0300
Message-ID: <47387CB0.90806@ru.mvista.com>
References: <200711022305.41127.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:21487 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751988AbXKLQRl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 11:17:41 -0500
In-Reply-To: <200711022305.41127.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_tf_set_cmd() helper for selecting/setting command and data phase
>   (note: DMA data phases are there for completness, they are not required ATM).

> * Set IDE_TFLAG_WRITE taskfile flag for write requests in __ide_do_rw_disk().

> * Convert __ide_do_rw_disk() to use the new ide_tf_set_cmd() helper.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
