From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
Date: Mon, 5 Aug 2002 13:08:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <386.470862622623$1028578800@news.gmane.org>
References: <20020804222542.GH13053@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020804222542.GH13053@ppc.vc.cvut.cz>
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


This has now become an utter JOKE!

If we examine Table 2-3 of the Retired SFF-8038i rev 1.0 the only document
to describe the behaviors of Bus Master IDE Status Register.
It is a R/W field.

Bit 7: Simplex RO
Bit 6: Device 1 DMA Capable RW
Bit 5: Device 0 DMA Capable RW
Bit 4: Reserved "MUST RETURN ZERO ON READS" !!!		Vendor Write
Bit 3: Reserved "MUST RETURN ZERO ON READS" !!!		Vendor Write
Bit 2: Bus Master Interrupt	STATUS R Clear W
Bit 1: Bus Master Error		STATUS R Clear W
Bit 0: Bus Master Active	STATUS

Vendor Write, is not a published or listed techincal term.
It is me trying to present this clearly enough so that the masses will see
how poorly the general understanding of the basics in 2.5.

Not to worry, I am sure UnderDog will come an save the day soon enough.

Regards,

Andre Hedrick
LAD Storage Consulting Group

