From: raymond pang <raymondpangxd@gmail.com>
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
Date: Thu, 28 Mar 2019 12:00:15 +0000
Message-ID: <CAHG4imPE3pNXAd5WvF-7hLyyZfpgAcT7KkVoCa+0iTGbHxxbvA@mail.gmail.com>
References: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
 <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

hi Jens,

Thanks for review. I'll fix them up.

Best regards,
Raymond

On Tue, Mar 26, 2019 at 2:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/25/19 9:07 PM, raymond pang wrote:
> > When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> > a stack virtual address. Stack DMA buffers must be avoided.
>
> The patch looks fine, but it's white space mangled so it won't apply.
> Additionally, you don't need to use kzfree, just use kfree.
>
> --
> Jens Axboe
>
