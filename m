From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
Date: Fri, 8 Feb 2019 06:45:13 -0700
Message-ID: <d0be11c8-cf25-500c-391f-52283f45383c@kernel.dk>
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
 <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 10/21/18 1:59 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.

Applied, thanks.

-- 
Jens Axboe
