From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New IDE driver for review
Date: Thu, 9 Jun 2005 17:10:23 +0200
Message-ID: <58cb370e050609081023f26433@mail.gmail.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030174FD@exmail1.se.axis.com>
	 <BFECAF9E178F144FAEF2BF4CE739C668014C7A6E@exmail1.se.axis.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:46687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261849AbVFIPKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 11:10:24 -0400
Received: by wproxy.gmail.com with SMTP id 68so178897wra
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 08:10:23 -0700 (PDT)
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C7A6E@exmail1.se.axis.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-ide@vger.kernel.org

On 6/9/05, Mikael Starvik <mikael.starvik@axis.com> wrote:
> Ok, updated driver and requested include files attached.

Thanks.

> The drivers are similar but it would still require many ugly ifdef:s or
> similar to combine them. I could of course extract the stuff that is the
> same to a common file to make the arch-specific files smaller. These drivers
> are rarley touched so I see no major maintanence benefit by combining them.

I still would like to see one driver:
* less maintenance for IDE people
* better readability of ide-v10.c
  (IDE specific stuff separated from arch specific stuff)
* good opportunity to cleanup ide-v10.c a bit

this won't require many ugly ifdef's, ie.

#ifdef v10
static void etrax_ide_set_pio(u8 setup, u8 strobe, u8 hold)
{
	*R_ATA_CONFIG =
		IO_FIELD(R_ATA_CONFIG, enable,         1 ) |
		IO_FIELD(R_ATA_CONFIG, dma_strobe, ATA_DMA2_STROBE) |
		IO_FIELD(R_ATA_CONFIG, dma_hold,    ATA_DMA2_HOLD) |
		IO_FIELD(R_ATA_CONFIG, pio_setup,    setup) |
		IO_FIELD(R_ATA_CONFIG, pio_strobe,   strobe) |
		IO_FIELD(R_ATA_CONFIG, pio_hold,      hold);
}
...
#else
static void etrax_ide_set_pio(u8 setup, u8 strobe, u8 hold)
{
	reg_ata_rw_ctrl0 ctrl0 = REG_RD(ata, regi_ata, rw_ctrl0);

	ctrl0.pio_setup = setup;
	ctrl0.pio_strb = strobe;
	ctrl0.pio_hold = hold;

	REG_WR(ata, regi_ata, rw_ctrl0, ctrl0);
}
...
#endif

and later just use etrax_ide_set_pio()

Bartlomiej
