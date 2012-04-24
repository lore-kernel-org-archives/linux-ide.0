From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Tue, 24 Apr 2012 14:00:19 +0200
Message-ID: <20120424120019.GE24089@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:50143 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab2DXL6O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Apr 2012 07:58:14 -0400
Content-Disposition: inline
In-Reply-To: <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: akpm@linux-foundation.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, sshtylyov@mvista.com, jgarzik@redhat.com, linux@arm.linux.org.uk, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

> -#if defined(CONFIG_HAVE_CLK)
>  	hpriv->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(hpriv->clk))
> -		dev_notice(&pdev->dev, "cannot get clkdev\n");
> -	else
> -		clk_enable(hpriv->clk);
> -#endif
> +	if (IS_ERR(hpriv->clk)) {
> +		dev_err(&pdev->dev, "cannot get clkdev\n");
> +		return PTR_ERR(hpriv->clk);
> +	}
> +
> +	clk_enable(hpriv->clk);

Sorry, but still wrong.

The clock is optional. If we can find a clock, turn it on. If not,
keep going....

You patch causes the missing clock to become a fatal error.

This sata_mv exists in multiple forms. It can be part of a SoC. It can
also be on a PCI bus. In the PCI form, it is unlikely to have a clk
which can be controlled. When built into a SoC, namely one of the
Orion family, dove, orion5x, mv78xx0 do not have a clock which can be
controlled. However kirkwood does have a clock.

So, kirkwood will provide a clock and expects that sata_mv will turn
it on. All the other ways of using sata_mv will not provide a clock,
but still expect the driver to be happy.

    Andrew
