From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/18] ide: fix registers loading order in ide_dump_ata_status()
Date: Fri, 09 Nov 2007 17:05:39 +0300
Message-ID: <47346933.8050804@ru.mvista.com>
References: <200711050020.57782.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1304 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753946AbXKIOF0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 09:05:26 -0500
In-Reply-To: <200711050020.57782.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Fix registers loading order in ide_dump_ata_status()/ide_read_24().

> Load registers in this order:
> * IDE_SECTOR_REG
> * IDE_LCYL_REG
> * IDE_HCYL_REG
> * IDE_SELECT_REG

> It shouldn't affect anything (just a usual paranoia to separate changes
> which change the way in which hardware is accessed from code cleanups).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
