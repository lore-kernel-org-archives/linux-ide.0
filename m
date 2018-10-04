From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: ep93xx: Use proper enums for directions
Date: Thu, 4 Oct 2018 13:48:33 +0200
Message-ID: <20181004114834eucas1p236dcc3d55686d347a82e79cc5b1628ba~aZWbN2bbZ0357203572eucas1p2e@eucas1p2.samsung.com>
References: <CGME20181004023814epcas3p163f7ce4d927c86d837015cdbe58c2936@epcas3p1.samsung.com>
        <20181004023754.15477-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004023754.15477-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-ide@vger.kernel.org


On 10/04/2018 04:37 AM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/ata/pata_ep93xx.c:662:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
>                                         ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:670:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
>                                         ~ ^~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:681:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_FROM_DEVICE;
>                        ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:692:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_TO_DEVICE;
>                        ~ ^~~~~~~~~~~~~
> 
> Use the equivalent valued enums from the expected type so that Clang no
> longer warns about a conversion.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
