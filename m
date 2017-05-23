From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix devres handling
Date: Tue, 23 May 2017 17:27:36 -0400
Message-ID: <20170523212736.GL13222@htj.duckdns.org>
References: <20170519230314.15718-1-linus.walleij@linaro.org>
 <20170523211608.GJ13222@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523211608.GJ13222@htj.duckdns.org>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, again.

On Tue, May 23, 2017 at 05:16:08PM -0400, Tejun Heo wrote:
> That's 96 bytes of difference, which seems too big for devres_node,
> especially on 32bit machines.  Can you check what gdb says on "print
> ((struct devres *)0)->data" or "print sizeof(struct devres_node)"?
> 
> There gotta be something else going on.  devres_alloc() returns the
> data pointer which is the same one which gets passed into the release
> function.

Also, can you please add throw in some printks and see what's being
returned from devres_alloc() and getting set on driver data?  This is
really weird.  I can't think of a reason why they'd differ.

Thanks.

-- 
tejun
