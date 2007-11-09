From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/15] ide: add ide_pktcmd_tf_load() helper
Date: Fri, 09 Nov 2007 21:07:34 +0300
Message-ID: <4734A1E6.4010205@ru.mvista.com>
References: <200710310030.27565.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2468 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbXKISHV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 13:07:21 -0500
In-Reply-To: <200710310030.27565.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add ide_pktcmd_tf_load() helper and convert ATAPI device drivers to use it.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
