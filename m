From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/18] ide: kill duplicate code in ide_dump_{ata,atapi}_status()
Date: Wed, 14 Nov 2007 13:11:50 +0300
Message-ID: <473AC9E6.5050009@ru.mvista.com>
References: <200711050023.56112.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:43791 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbXKNKLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 05:11:39 -0500
In-Reply-To: <200711050023.56112.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Move the common code from ide_dump_{ata,atapi}_status() to
>   ide_dump_status().

> * ide_dump_{ata,atapi}_status() -> ide_dump_{ata,atapi}_error().

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
