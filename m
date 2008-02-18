From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: DMA on ht6560b?
Date: Mon, 18 Feb 2008 15:13:53 +0100
Message-ID: <47B992A1.2030008@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pelian.kabelfoon.nl ([62.45.45.43]:52926 "EHLO
	pelian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYBRONy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 09:13:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hi,

With digging into the code...

I think the ht6560b controller supports DMA. At least it did so in 2.2 
(where hdparm could still turn it on). DMA in 2.2 would improve the HD 
from about 1M/s to 4M/s. So that's quite interesting.
Also the datasheet claims that there is full ANSI ATA-4a support. 
According to the ATA table on wikipedia that should include up to mwdma 
2 and udma33.

What's the magic that will turn it on for the ht6560b controller?
I would guess at the [sm]wdma_mask fields in hwif_t? Plus something for 
set_dma_mode?
Some help would be appreciated.

Thanks,
Jan Evert

