From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: ep93xx: Use proper enums for directions
Date: Thu, 4 Oct 2018 08:26:32 -0600
Message-ID: <139aaf99-1189-a3cb-b801-fdf16a6ec9ac@kernel.dk>
References: <20181004023754.15477-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004023754.15477-1-natechancellor@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-ide@vger.kernel.org

On 10/3/18 8:37 PM, Nathan Chancellor wrote:
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

Applied, thanks.

-- 
Jens Axboe
