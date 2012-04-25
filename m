From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
Date: Wed, 25 Apr 2012 11:31:09 +0200
Message-ID: <20120425093109.GC2116@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
 <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
 <20120425052802.GF13489@lunn.ch>
 <20375.40225.227084.644318@ipc1.ka-ro>
 <20120425071418.GA2116@lunn.ch>
 <20375.46953.269684.680915@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20375.46953.269684.680915@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar Wa??mann <LW@KARO-electronics.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, sshtylyov@mvista.com, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, viresh kumar <viresh.linux@gmail.com>, mturquette@linaro.org, akpm@linux-foundation.org, jgarzik@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

> If an arch has HAVE_CLK enabled it must provide valid clocks (be it
> dummy clocks) for all devices it supports.

So, lets take the theoretical exaple of a unicore32 PUV3

config ARCH_PUV3
        def_bool y
        select CPU_UCV2
        select GENERIC_CLOCKEVENTS
        select HAVE_CLK
        select ARCH_REQUIRE_GPIOLIB
        select ARCH_HAS_CPUFREQ

Seems like this somewhat unknown, to me at least, architecture, also
supports PCI. So i plug in an HP Adaptec AIC8120 SATA host bus adapter
into a spare PCI slot. This uses the Marvell 88SX6041, which the
SATA_MV driver supports.

Should i expect that the unicore32 PUV3 has created a dummy clk for
this case?

Thanks
	Andrew
