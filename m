From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] ide-disk: extend timeout for PIO-in commands
Date: Fri, 09 Nov 2007 17:03:28 +0300
Message-ID: <473468B0.8030101@ru.mvista.com>
References: <200711022305.36715.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1296 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759942AbXKIODP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 09:03:15 -0500
In-Reply-To: <200711022305.36715.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> s/WAIT_CMD/WAIT_WORSTCASE/ to make the timeout the same as in do_rw_taskfile()

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
