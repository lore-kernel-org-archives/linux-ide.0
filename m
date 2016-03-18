From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1 1/1] ata: sata_dwc_460ex: make driver works again
Date: Fri, 18 Mar 2016 10:33:45 -0700
Message-ID: <20160318173345.GA19137@kroah.com>
References: <1458312535-105427-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458312535-105427-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Mans Rullgard <mans@mansr.com>, stable@vger.kernel.org, #@black.fi.intel.com, v4.1+@black.fi.intel.com
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 18, 2016 at 04:48:55PM +0200, Andy Shevchenko wrote:
> This patch basically reverts three commits
> 	8d5fe8d sata_dwc_460ex: indent an if statement
> 	db7a657f sata_dwc_460ex: re-use hsdev->dev instead of dwc_dev
> 	8b34448 sata_dwc_460ex: move to generic DMA driver
> to make driver works on _stable_ kernels only.
> 
> The mentioned set has few flaws which are addressed in the continuation of this
> series. At that time no-one has a possibility to check that on an actual
> hardware. But now I have access to it and thus can be sure that everything
> works beforehand.
> 
> The decision to revert is based on the fact of amount of efforts needed to back
> port necessary changes.
> 
> Fixes: 8b3444852a2b ("sata_dwc_460ex: move to generic DMA driver")
> Cc: stable@vger.kernel.org # v4.1+
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Tejun, this is intended explicitly for stable kernels only (v4.1..v4.6-rcX).
> Mans and I are going to fix it in the upstrem this cycle. I have alredy send a
> patch series regarding DMA fixes.
> 
>  drivers/ata/sata_dwc_460ex.c | 753 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 623 insertions(+), 130 deletions(-)

That's not ok for a stable patch, sorry, please go read
Documentation/stable_kernel_rules.txt.

Just revert the individual patches instead, what's wrong with that?

thanks,

greg k-h
