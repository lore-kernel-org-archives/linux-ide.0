From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Wed, 25 Apr 2012 09:14:18 +0200
Message-ID: <20120425071418.GA2116@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
 <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
 <20120425052802.GF13489@lunn.ch>
 <20375.40225.227084.644318@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:51293 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2DYHMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Apr 2012 03:12:14 -0400
Content-Disposition: inline
In-Reply-To: <20375.40225.227084.644318@ipc1.ka-ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lothar Wa??mann <LW@KARO-electronics.de>
Cc: Andrew Lunn <andrew@lunn.ch>, viresh kumar <viresh.linux@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, sshtylyov@mvista.com, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mturquette@linaro.org, akpm@linux-foundation.org, jgarzik@redhat.com, linux-arm-kernel@lists.infradead.org

> AFAICT the PCI archs do not have HAVE_CLK enabled. Thus they will have
> a dummy clk API in place that provides the driver with a non-error
> clk_get() return value.
 
Hi Lothar

Please could you explain this a little bit more. What exactly is a PCI
arch?

Most of the Orion SoC have PCIe busses. Does this make them an PCI
arch? Because they also have HAVE_CLK. There are more SoCs with PCI.

      Thanks
	Andrew
