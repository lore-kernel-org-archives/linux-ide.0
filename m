From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] sata_mv: More error handling for phy_power_off() in
 mv_platform_remove()
Date: Tue, 3 Feb 2015 07:10:20 -0500
Message-ID: <20150203121020.GC19463@htj.dyndns.org>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54D08732.4050601@users.sourceforge.net>
 <54D08871.6030304@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D08871.6030304@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 03, 2015 at 09:36:01AM +0100, SF Markus Elfring wrote:
...
> @@ -4215,7 +4215,9 @@ static int mv_platform_remove(struct platform_device *pdev)
>  			clk_disable_unprepare(hpriv->port_clks[port]);
>  			clk_put(hpriv->port_clks[port]);
>  		}
> -		phy_power_off(hpriv->port_phys[port]);
> +		rc = phy_power_off(hpriv->port_phys[port]);
> +		if (rc)
> +			return rc;

So, this is a removal function which is ignoring failure from turning
off phy, which seems like the right thing to do.  The same thing with
suspend routines.  If something auxliary which isn't strictly
necessary in reaching suspend state fails, the failure should be
ignored.

Running static code analysis to locate trivial irregularities and
performing identity transformations is fine, even great, but you're
changing the behavior here without actually understanding what's going
on.  Please don't do these things automatically.

Thanks.

-- 
tejun
