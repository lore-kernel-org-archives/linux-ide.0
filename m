From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_samsung_cf: fix ata_host_activate() failure handling
Date: Tue, 15 Apr 2014 13:45:34 +0200
Message-ID: <2600390.JXZXrjzsbS@amdc1032>
References: <6050762.sdUI3gZZlK@amdc1032>
 <000801cf4d48$54c45210$fe4cf630$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <000801cf4d48$54c45210$fe4cf630$%han@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ben Dooks' <ben-linux@fluff.org>, 'Tejun Heo' <tj@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org


Hi,

Tejun, could you please also pick this one?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Tuesday, April 01, 2014 10:18:46 AM Jingoo Han wrote:
> On Tuesday, April 01, 2014 2:53 AM, Tejun Heo wrote:
> > 
> > Add missing clk_disable() call to ata_host_activate() failure path.
> > 
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
> 
> Best regards,
> Jingoo Han
> 
> > ---
> >  drivers/ata/pata_samsung_cf.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > Index: b/drivers/ata/pata_samsung_cf.c
> > ===================================================================
> > --- a/drivers/ata/pata_samsung_cf.c	2014-03-14 16:45:04.344724378 +0100
> > +++ b/drivers/ata/pata_samsung_cf.c	2014-03-31 18:31:58.083631437 +0200
> > @@ -594,9 +594,13 @@ static int __init pata_s3c_probe(struct
> > 
> >  	platform_set_drvdata(pdev, host);
> > 
> > -	return ata_host_activate(host, info->irq,
> > -			info->irq ? pata_s3c_irq : NULL,
> > -			0, &pata_s3c_sht);
> > +	ret = ata_host_activate(host, info->irq,
> > +				info->irq ? pata_s3c_irq : NULL,
> > +				0, &pata_s3c_sht);
> > +	if (ret)
> > +		goto stop_clk;
> > +
> > +	return 0;
> > 
> >  stop_clk:
> >  	clk_disable(info->clk);
> > 
> > --
