From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Tue, 24 Apr 2012 09:26:53 +0200
Message-ID: <20120424072653.GB24089@lunn.ch>
References: <20120424070426.GA24089@lunn.ch>
 <4F9650B3.9030406@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49922 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab2DXHYu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Apr 2012 03:24:50 -0400
Content-Disposition: inline
In-Reply-To: <4F9650B3.9030406@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "sshtylyov@mvista.com" <sshtylyov@mvista.com>, spear-devel <spear-devel@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "jgarzik@redhat.com" <jgarzik@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 24, 2012 at 12:35:23PM +0530, Viresh Kumar wrote:
> On 4/24/2012 12:34 PM, Andrew Lunn wrote:
> > I don't think this change is correct. With the old semantics, it was:
> 
> Sorry. :(
> 
> > If we have CLK support, we expect there to be a clock for sata_mv, and
> > if there is no such clock, output a notice message, something is
> > probably wrong, i expected there to be a clock.
> > 
> > The new semantics are:
> > 
> > We expect there to be a clock for sata_mv, and if there is no such
> > clock, output a notice message, something is probably wrong, i
> > expected there to be a clock.
> > 
> > We are going to see this notice message much more, when it is not
> > expected.
> 
> So, the only problem is this message?
> How do you suggest to tackle this now. Have #ifdef,#endif around this print?

Well, adding #ifdef defeats the point of adding dummy implementations.

Maybe, rather than return -ENODEV, return -ENOTSUP.

IS_ERR() still returns true, so in most cases, no code needs
changing. However, when you need to differentiate between, "clock does
not exists" and "Dummy clock functions being used", you can tell the
difference. mv_sata could look like:

        hpriv->clk = clk_get(&pdev->dev, NULL);
        if (IS_ERR(hpriv->clk))
	        if (PTR_ERR(hpriv->clk) == -ENODEV)
		        dev_notice(&pdev->dev, "cannot get clkdev\n");
        else
                clk_prepare_enable(hpriv->clk);


You would however, need to look at all uses of clk_get and see if any
are looked for ENODEV, and not just IS_ERR(), and fix those....

	Andrew

