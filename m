From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/15] ide: fix registers loading order for WIN_SMART in
 execute_drive_cmd()
Date: Sun, 28 Oct 2007 21:31:00 +0300
Message-ID: <4724D564.8070500@ru.mvista.com>
References: <200710271946.06768.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7488 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751588AbXJ1Say (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 14:30:54 -0400
In-Reply-To: <200710271946.06768.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Fix registers loading order for REQ_TYPE_ATA_CMD request with WIN_SMART
> command in execute_drive_cmd() (load IDE_FEATURE_REG and IDE_SECTOR_REG
> before loading IDE_LCYL_REG and IDE_HCYL_REG).

> It shouldn't affect anything (just a usual paranoia to separate changes
> which change the way in which hardware is accessed from code cleanups).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
