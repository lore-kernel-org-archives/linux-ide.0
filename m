From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/15] ide-{floppy,tape,scsi}: fix register loading order
 when issuing packet command
Date: Sun, 04 Nov 2007 16:09:23 +0300
Message-ID: <472DC483.8060700@ru.mvista.com>
References: <200710310029.43301.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10689 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755202AbXKDNJO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 08:09:14 -0500
In-Reply-To: <200710310029.43301.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Load IDE_BCOUNTL_REG before IDE_BCOUNTH_REG when issuing packet command.

> It shouldn't affect anything (just a usual paranoia to separate changes
> which change the way in which hardware is accessed from code cleanups).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
