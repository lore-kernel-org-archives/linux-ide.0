From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: add ide_dump_identify() debug helper
Date: Tue, 25 Dec 2007 13:26:21 +0300
Message-ID: <4770DACD.2080503@ru.mvista.com>
References: <200712232243.36838.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:52303 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751206AbXLYKZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Dec 2007 05:25:52 -0500
In-Reply-To: <200712232243.36838.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_dump_identify() debug helper for dumping raw identify data in
>   the hdparm friendly format (== the identify data can be extracted from
>   dmesg output and passed to hdparm --Istdin).

> * Dump identify data in ide-probe.c::do_identify() if DEBUG is enabled.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
