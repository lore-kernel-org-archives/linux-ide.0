From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: remove deprecated use of pci api
Date: Wed, 8 Apr 2015 10:57:04 -0400
Message-ID: <20150408145704.GL10582@htj.duckdns.org>
References: <1428496450-11244-1-git-send-email-lambert.quentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428496450-11244-1-git-send-email-lambert.quentin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Apr 08, 2015 at 02:34:10PM +0200, Quentin Lambert wrote:
> Replace occurences of the pci api by appropriate call to the dma api.
> 
> A simplified version of the semantic patch that finds this problem is as
> follows: (http://coccinelle.lip6.fr)
> 
> @deprecated@
> idexpression id;
> position p;
> @@
> 
> (
>   pci_dma_supported@p ( id, ...)
> |
>   pci_alloc_consistent@p ( id, ...)
> )
> 
> @bad1@
> idexpression id;
> position deprecated.p;
> @@
> ...when != &id->dev
>    when != pci_get_drvdata ( id )
>    when != pci_enable_device ( id )
> (
>   pci_dma_supported@p ( id, ...)
> |
>   pci_alloc_consistent@p ( id, ...)
> )
> 
> @depends on !bad1@
> idexpression id;
> expression direction;
> position deprecated.p;
> @@
> 
> (
> - pci_dma_supported@p ( id,
> + dma_supported ( &id->dev,
> ...
> + , GFP_ATOMIC
>   )
> |
> - pci_alloc_consistent@p ( id,
> + dma_alloc_coherent ( &id->dev,
> ...
> + , GFP_ATOMIC
>   )
> )
> 
> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>

Applied to libata/for-4.1.  Thanks.

-- 
tejun
