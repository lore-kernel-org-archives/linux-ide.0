From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix devres handling
Date: Tue, 30 May 2017 13:59:09 -0400
Message-ID: <20170530175909.GA15169@htj.duckdns.org>
References: <20170519230314.15718-1-linus.walleij@linaro.org>
 <20170523211608.GJ13222@htj.duckdns.org>
 <CACRpkdY696hTcdDwoCg6GPi_VG7Q=iC8yt8iJQMQ5FYQ_S3fqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY696hTcdDwoCg6GPi_VG7Q=iC8yt8iJQMQ5FYQ_S3fqw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

On Tue, May 30, 2017 at 11:21:24AM +0200, Linus Walleij wrote:
> This is because my driver issues platform_set_drvdata(pdev)
> on the same struct device * overwriting the data with
> its own. That function is just an alias for dev_set_drvdata().

I see.

> Amazingly, libata survives this until release.

That is surprising given that libata does depend on that drvdata quite
a bit.

> Maybe we should print a warning if dev_get_drvdata()
> and res differ? It's a sign that something is wrong because
> someone screwed with the drvdata behind the back of
> libata.

Please feel free to submit a patch to add WARN_ON there.

> I guess I will simply make a cleanup series for these,
> making sure they use host->private_data instead and do not
> double-write the drvdata.

Great.

Thanks for working on this!

-- 
tejun
