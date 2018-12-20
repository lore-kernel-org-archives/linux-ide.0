From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
Date: Thu, 20 Dec 2018 11:01:24 -0700
Message-ID: <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
 <20181121130439.22255-1-tiny.windzz@gmail.com>
 <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Yangtao Li <tiny.windzz@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/20/18 10:03 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 11/21/2018 02:04 PM, Yangtao Li wrote:
>> of_find_node_by_path() acquires a reference to the node
>> returned by it and that reference needs to be dropped by its caller.
>> bl_idle_init() doesn't do that, so fix it.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Yangtao, were you going to resend this one?

-- 
Jens Axboe
