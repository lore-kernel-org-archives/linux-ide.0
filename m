From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata: ahci-da850: Fix some error handling paths in
 'ahci_da850_probe()'
Date: Wed, 16 Aug 2017 07:40:32 -0700
Message-ID: <20170816144032.GE4087514@devbig577.frc2.facebook.com>
References: <20170816053103.19773-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816053103.19773-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Aug 16, 2017 at 07:31:03AM +0200, Christophe JAILLET wrote:
> 'rc' is known to be 0 at this point.
> If 'platform_get_resource()' or 'devm_ioremap()' fail, return -ENOMEM
> instead of 0 which means success.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to libata/for-4.13-fixes w/ Sergei's suggestion applied.

Thanks.

-- 
tejun
