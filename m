From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/64] pata_amd: remove bogus code from timing_setup()
Date: Mon, 18 Jan 2010 19:18:45 +0100
Message-ID: <201001181918.45314.bzolnier@gmail.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171420.14623.85263.sendpatchset@localhost> <20100118175037.23727d64@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42957 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0ARSXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 13:23:37 -0500
In-Reply-To: <20100118175037.23727d64@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 18 January 2010 06:50:37 pm Alan Cox wrote:
> On Mon, 18 Jan 2010 18:14:20 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_amd: remove bogus code from timing_setup()
> > 
> > DMA modes don't have 8-bit timings.

s/timings/data timings/ [ though it should be obvious from the context ]

> If you are in a DMA based mode then you have 8bit timings for writes to
> the non data registers. You can get an 8bit timed access to the other
> drive even in DMA mode. 

Sorry but this confuses taskfile timings (which are always PIO mode based
timings) with data timings (the removed code deals with the latter only)..

also please refer to ata_timings[] in drivers/ata/libata-core.c
(columns 3, 4 and 5 are the ones to look at):

static const struct ata_timing ata_timing[] = {
/*      { XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 0,  960,   0 }, */
        { XFER_PIO_0,     70, 290, 240, 600, 165, 150, 0,  600,   0 },
        { XFER_PIO_1,     50, 290,  93, 383, 125, 100, 0,  383,   0 },
        { XFER_PIO_2,     30, 290,  40, 330, 100,  90, 0,  240,   0 },
        { XFER_PIO_3,     30,  80,  70, 180,  80,  70, 0,  180,   0 },
        { XFER_PIO_4,     25,  70,  25, 120,  70,  25, 0,  120,   0 },
        { XFER_PIO_5,     15,  65,  25, 100,  65,  25, 0,  100,   0 },
        { XFER_PIO_6,     10,  55,  20,  80,  55,  20, 0,   80,   0 },

        { XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 50, 960,   0 },
        { XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 480,   0 },
        { XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 20, 240,   0 },

        { XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 480,   0 },
        { XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 5,  150,   0 },
        { XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 5,  120,   0 },
        { XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 5,  100,   0 },
        { XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20, 5,   80,   0 },

/*      { XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0, 0,    0, 150 }, */
        { XFER_UDMA_0,     0,   0,   0,   0,   0,   0, 0,    0, 120 },
        { XFER_UDMA_1,     0,   0,   0,   0,   0,   0, 0,    0,  80 },
        { XFER_UDMA_2,     0,   0,   0,   0,   0,   0, 0,    0,  60 },
        { XFER_UDMA_3,     0,   0,   0,   0,   0,   0, 0,    0,  45 },
        { XFER_UDMA_4,     0,   0,   0,   0,   0,   0, 0,    0,  30 },
        { XFER_UDMA_5,     0,   0,   0,   0,   0,   0, 0,    0,  20 },
        { XFER_UDMA_6,     0,   0,   0,   0,   0,   0, 0,    0,  15 },

        { 0xFF }
};

--
Bartlomiej Zolnierkiewicz
