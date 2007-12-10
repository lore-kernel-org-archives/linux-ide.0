From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/20] ide: clear HOB bit for REQ_TYPE_ATA_CMD requests
 in ide_end_drive_cmd()
Date: Mon, 10 Dec 2007 15:54:35 +0300
Message-ID: <475D370B.4000504@ru.mvista.com>
References: <200712092209.40545.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48057 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751941AbXLJMyO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 07:54:14 -0500
In-Reply-To: <200712092209.40545.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ide_dump_status() may set HOB bit before ide_end_drive_cmd() is called.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
