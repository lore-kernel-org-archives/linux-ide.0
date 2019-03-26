From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
Date: Tue, 26 Mar 2019 08:09:13 -0600
Message-ID: <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
References: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: raymond pang <raymondpangxd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 3/25/19 9:07 PM, raymond pang wrote:
> When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> a stack virtual address. Stack DMA buffers must be avoided.

The patch looks fine, but it's white space mangled so it won't apply.
Additionally, you don't need to use kzfree, just use kfree.

-- 
Jens Axboe
