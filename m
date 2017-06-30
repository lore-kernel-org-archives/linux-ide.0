From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 08:01:06 -0400
Message-ID: <20170630120106.GB16820@htj.duckdns.org>
References: <20170630052210.GA19186@embeddedgus>
 <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 30, 2017 at 12:42:38PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 6/30/2017 8:22 AM, Gustavo A. R. Silva wrote:
> 
> > Print error message and propagate the return value of
> > platform_get_irq on failure.
> 
>    You should have probably mentioned that this function no longer returns 0
> on error.

Yeah, the patches looks good to me but I'd really appreciate more
context in the changelogs.  Gustavo, can you please respin the
patches?

Thanks.

-- 
tejun
