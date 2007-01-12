From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/19] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA
Date: Fri, 12 Jan 2007 22:24:18 +0300
Message-ID: <45A7E062.3080403@ru.mvista.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain> <20070112042710.28794.40403.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:34483 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964982AbXALTYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 14:24:19 -0500
In-Reply-To: <20070112042710.28794.40403.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA #ifdef-s

    Nice to see you riding again. :-)

> In drivers/ide/Kconfig BLK_DEV_TRM290 depends on
> BLK_DEV_IDEDMA_PCI (on which is BLK_DEV_IDEDMA dependant on).

    I also remember you urging me to get rid of ide_setup_dma() call there. ;-)

MBR, Sergei
