From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 47/64] ide: add drive->dma_mode field
Date: Tue, 19 Jan 2010 01:43:21 -0800 (PST)
Message-ID: <20100119.014321.194885122.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172035.14623.50000.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34520
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755840Ab0ASJnN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 04:43:13 -0500
In-Reply-To: <20100118172035.14623.50000.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:20:35 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add drive->dma_mode field
> 
> Add dma_mode field to ide_drive_t matching dma_mode field used in
> struct ata_device.
> 
> The validity of the field is restricted to ->dma_pio_mode method
> only currently in IDE subsystem.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
