From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: officially deprecated the legacy IDE driver
Date: Wed, 08 May 2019 13:14:40 -0700 (PDT)
Message-ID: <20190508.131440.579353613998007502.davem@davemloft.net>
References: <20190508180140.12364-1-hch@lst.de>
        <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: hch@lst.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 8 May 2019 12:08:49 -0600

> On 5/8/19 12:01 PM, Christoph Hellwig wrote:
>> After a recent chat with Dave we agreed to try to finally kill off the
>> legacy IDE code base.  Set a two year grace period in which we try
>> to move everyone over.  There are a few pieces of hardware not
>> supported by libata yet, but for many of them we aren't even sure
>> if there are any users.  For those that have users we have usually
>> found a volunteer to add libata support.
> 
> I fully support this.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>

Yeah I totally support this too, I'll apply.
