From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation
	of clk code
Date: Wed, 25 Apr 2012 11:37:44 +0100
Message-ID: <20120425103744.GT24211@n2100.arm.linux.org.uk>
References: <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com> <20120424120019.GE24089@lunn.ch> <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com> <20120424201802.GE3628@n2100.arm.linux.org.uk> <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com> <20120425052802.GF13489@lunn.ch> <20375.40225.227084.644318@ipc1.ka-ro> <20120425071418.GA2116@lunn.ch> <20375.46953.269684.680915@ipc1.ka-ro> <20120425093109.GC2116@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120425093109.GC2116@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lothar Wa??mann <LW@KARO-electronics.de>, viresh kumar <viresh.linux@gmail.com>, sshtylyov@mvista.com, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mturquette@linaro.org, akpm@linux-foundation.org, jgarzik@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Wed, Apr 25, 2012 at 11:31:09AM +0200, Andrew Lunn wrote:
> > If an arch has HAVE_CLK enabled it must provide valid clocks (be it
> > dummy clocks) for all devices it supports.
> 
> So, lets take the theoretical exaple of a unicore32 PUV3
> 
> config ARCH_PUV3
>         def_bool y
>         select CPU_UCV2
>         select GENERIC_CLOCKEVENTS
>         select HAVE_CLK
>         select ARCH_REQUIRE_GPIOLIB
>         select ARCH_HAS_CPUFREQ
> 
> Seems like this somewhat unknown, to me at least, architecture, also
> supports PCI. So i plug in an HP Adaptec AIC8120 SATA host bus adapter
> into a spare PCI slot. This uses the Marvell 88SX6041, which the
> SATA_MV driver supports.
> 
> Should i expect that the unicore32 PUV3 has created a dummy clk for
> this case?

Are you going to bother answering the detailed email I sent describing
my POV on this case?
