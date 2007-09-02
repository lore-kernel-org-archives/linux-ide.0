From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/10] aec62xx: remove ->init_setup
Date: Sun, 02 Sep 2007 18:57:38 +0400
Message-ID: <46DACF62.2040209@ru.mvista.com>
References: <200708292318.58193.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53413 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750704AbXIBOyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 10:54:50 -0400
In-Reply-To: <200708292318.58193.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Merge init_setup_{aec62xx,aec6x80}() into aec62xx_init_one().

> While at it:

> * Use id->driver_data instead of dev->device.

> * Use ATA_UDMA6 define.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
