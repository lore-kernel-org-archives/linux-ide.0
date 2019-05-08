From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ide: officially deprecated the legacy IDE driver
Date: Wed, 8 May 2019 12:08:49 -0600
Message-ID: <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
References: <20190508180140.12364-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508180140.12364-1-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 5/8/19 12:01 PM, Christoph Hellwig wrote:
> After a recent chat with Dave we agreed to try to finally kill off the
> legacy IDE code base.  Set a two year grace period in which we try
> to move everyone over.  There are a few pieces of hardware not
> supported by libata yet, but for many of them we aren't even sure
> if there are any users.  For those that have users we have usually
> found a volunteer to add libata support.

I fully support this.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
