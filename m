From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
Date: Sun, 9 Sep 2018 13:13:25 +0200
Message-ID: <463dbbdc-7afc-bee8-8da1-bbe70b4aec26@users.sourceforge.net>
References: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>, kernel-janitors@vger.kernel.org
Cc: Coccinelle <cocci@systeme.lip6.fr>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Alistair Popple <alistair@popple.id.au>, Anatolij Gustschin <agust@denx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>, Gilles Muller <Gilles.Muller@lip6.fr>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Kumar Gala <galak@kernel.crashing.org>
List-Id: linux-ide@vger.kernel.org

How do you think about to add any more meta-data for this semantic patch script?

* SPDX identifier
* Copyright information
* Confidence level

https://bottest.wiki.kernel.org/coccicheck


> +virtual context

Further variables will be needed if you would like to use corresponding
operation modes (besides “patch”).


> +expression reg;
> +expression set;
> +expression clear;

I propose once more to avoid the repetition of (unnecessary) SmPL code.
This part could be written like the following instead.

+expression clear, set, reg;


If you would increase the usage of SmPL disjunctions, the specification
of duplicate SmPL code could be reduced considerably.

* Would you like to merge SmPL rules based on the distinction between
  the data types “u32” and “u64”?

* Did you identify any optional code in this transformation approach?


> +@@
> +expression base;
> +expression offset;
> +expression value;
> +@@
> +
> +- mtu3_setbits(base, offset, value);
> ++ setbits32(base + offset, value);
> +
> +@@
> +expression base;
> +expression offset;
> +expression mask;
> +@@
> +
> +- mtu3_clrbits(base, offset, mask);
> ++ clrbits32(base + offset, mask);

Another update suggestion:

+@replacement@
+expression base, offset;
+@@
+(
+-mtu3_clrbits
++clrbits32
+|
+-mtu3_setbits
++setbits32
+)(base
+-     ,
++ +
+  offset, ...);


Would you like to try further software fine-tuning out?

Regards,
Markus
