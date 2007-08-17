From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Fri, 17 Aug 2007 19:39:12 +0400
Message-ID: <46C5C120.5030202@ru.mvista.com>
References: <20070808143320.0de8c5d9@the-village.bc.nu>	<46BE1452.4010603@ru.mvista.com> <20070811214439.640b65e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49886 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755659AbXHQPgs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 11:36:48 -0400
In-Reply-To: <20070811214439.640b65e9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello.

Alan Cox wrote:

>>    That function rocks (except I didn't get what the address setup timings 
>>mean to SW/MW DMA)...

> They don't, it merges the DMA and PIO ones and you end up with the PIO
> ones.

    What I meant there was this table from libata-core.c:

/*
  * PIO 0-4, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
  * These were taken from ATA/ATAPI-6 standard, rev 0a, except
  * for UDMA6, which is currently supported only by Maxtor drives.
  *
  * For PIO 5/6 MWDMA 3/4 see the CFA specification 3.0.
  */

static const struct ata_timing ata_timing[] = {

         { XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
         { XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
         { XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
         { XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },

         { XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
         { XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
         { XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
         { XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
         { XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },

/*      { XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 }, */
 
 

         { XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
         { XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
         { XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },

         { XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
         { XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
         { XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },

         { XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
         { XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
         { XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
         { XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },

         { XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
         { XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
         { XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },

/*      { XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 }, */

         { 0xFF }
};

    Note non-zero values in column 2 of the initilaizers for SW/MW DMA lines 
-- that's the 'setup' field of 'struct ata_timings'. Where did those figures 
come from?
    Ah, I see -- that must be *data* setup/hold times summed up. What I don't 
see is how it connects with the address setup time...

>>> 	regD |= 0x20 << adev->devno;

>>    Hm, is setting of "drive DMA capable" bits really needed in the driver. 
>>Doesn't libata core itself do this?

> For most hardware it doesn't matter. The CMD64x driver code I have all
> bothers to set it. I don't know if its needed, someone with the bits
> handy could find out I guess, but if we arent sure it does no harm.

    I've removed that from the IDE driver -- none yelled yet. :-)

MBR, Sergei
