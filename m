From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
Date: Thu, 7 Feb 2019 13:11:17 +0100
Message-ID: <db237310-2a6f-e390-7032-d33262916216@samsung.com>
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
        <CGME20181021200001epcas1p29d6bcf070cdacfe093b17e2c2c3b6f50@epcas1p2.samsung.com>
        <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 10/21/2018 09:59 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
