From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 37/64] serverworks: cleanup svwks_udma_filter()
Date: Tue, 19 Jan 2010 01:26:59 -0800 (PST)
Message-ID: <20100119.012659.153356222.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171922.14623.96042.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46337
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932163Ab0ASJ0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 04:26:49 -0500
In-Reply-To: <20100118171922.14623.96042.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:19:22 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] serverworks: cleanup svwks_udma_filter()
> 
> * remove dead OSB4 UDMA support
> * remove unreachable code
> * make isa_dev local to ->init_chipset
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
