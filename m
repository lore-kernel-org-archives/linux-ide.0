From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/5] introduce
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 functions
Date: Fri, 07 Sep 2018 14:57:17 -0700 (PDT)
Message-ID: <20180907.145717.248815695221355297.davem@davemloft.net>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: clabbe@baylibre.com
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org, cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-ide@vger.kernel.org


If you are going to do this, please add for_each_set_bit64() and similar.

For example, see:

https://marc.info/?l=linux-netdev&m=153633391214025&w=2
