From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/9] ide: use ide_destroy_dmatable() instead of pci_unmap_sg()
Date: Sat, 29 Dec 2007 16:43:46 +0300
Message-ID: <47764F12.9080900@ru.mvista.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191223.1357.78845.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11992 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753391AbXL2NnS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Dec 2007 08:43:18 -0500
In-Reply-To: <20071227191223.1357.78845.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Use ide_destroy_dmatable() in:
> * ide-dma.c::ide_build_dmatable()
> * sgiioc4.c::sgiioc4_build_dma_table()
> * pmac.c::pmac_ide_{build,destroy}_dmatable()

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

