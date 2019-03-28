From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
Date: Thu, 28 Mar 2019 08:17:04 -0600
Message-ID: <6c7d28e9-ac56-bffe-05c0-2ca7ea6ff37f@kernel.dk>
References: <20190328121925.15488-1-raymondpangxd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328121925.15488-1-raymondpangxd@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: raymond pang <raymondpangxd@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 3/28/19 6:19 AM, raymond pang wrote:
> When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> a stack virtual address. Stack DMA buffers must be avoided.

Thanks, applied.

-- 
Jens Axboe
