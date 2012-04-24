From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Tue, 24 Apr 2012 22:35:26 +0530
Message-ID: <CAOh2x==itVxwPAFaHgDW4L6FHZrBjWKSV2u4RCEqXHCEWgqHsg@mail.gmail.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
	<abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
	<20120424120019.GE24089@lunn.ch>
	<CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
	<20120424142939.GG24089@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61983 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab2DXRF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2012 13:05:27 -0400
In-Reply-To: <20120424142939.GG24089@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Viresh Kumar <viresh.kumar@st.com>, akpm@linux-foundation.org, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, sshtylyov@mvista.com, jgarzik@redhat.com, linux@arm.linux.org.uk, linux-ide@vger.kernel.org

On 4/24/12, Andrew Lunn <andrew@lunn.ch> wrote:
> static int __clk_enable(struct clk *clk)
> {
>         int ret = 0;
>
>         if (!clk)
>                 return 0;
>
>         if (WARN_ON(clk->prepare_count == 0))
>                 return -ESHUTDOWN;
>
>    this should actually be clk_prepare_enable(). Did you see my
>    patches adding generic clk framework support for Orion. I fixed
>    this as part of that patch set.

Sorry for missing it earlier. Ya i know it must be clk_prepare_enable(),
but it wasn't motive of my patchset.

Sorry, i haven't gone through your patches for Orion.

--
viresh
