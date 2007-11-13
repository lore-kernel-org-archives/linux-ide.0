From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/13] ide: (hopefully) fix VDMA for CS5520
Date: Tue, 13 Nov 2007 14:17:44 +0300
Message-ID: <473987D8.6030409@ru.mvista.com>
References: <200711130001.28320.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:31768 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753480AbXKMLRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 06:17:33 -0500
In-Reply-To: <200711130001.28320.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Set the correct hwif->dma_base for the second channel in
>   ide_get_or_set_dma_base().

> * Remove DMA enable code from cs5520_set_pio_mode(), this can
>   be handled by the generic ->dma_host_on method now.

> * Add VDMA check to ide_config_drive_speed().

> * drive->using_dma was never enabled since cs5520 host driver's
>   ->ide_dma_on method overrided the generic ->ide_dma_on (so
>   __ide_dma_on() was never called, drive->using_dma was never set
>   and VDMA was never used since it depends on drive->using_dma).

>   Fix it by using ->dma_host_on method instead of ->ide_dma_on
>   (also add matching ->dma_host_off method).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
