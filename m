From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/9] ide: fix ide_intr() for non-PCI devices and CONFIG_BLK_DEV_IDEPCI=y
Date: Fri, 28 Dec 2007 15:15:32 +0300
Message-ID: <4774E8E4.1080400@ru.mvista.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191207.1357.24118.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7189 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752967AbXL1MPE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Dec 2007 07:15:04 -0500
In-Reply-To: <20071227191207.1357.24118.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> 'hwif->pci_dev && !hwif->pci_dev->vendor' condition is never true,
> check for 'hwif->chipset != ide_pci' instead.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
