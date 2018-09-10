From: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH 1/5] powerpc: rename setbits32/clrbits32 to
 setbits32_be/clrbits32_be
Date: Mon, 10 Sep 2018 20:50:39 +0200
Message-ID: <20180910185039.GB7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-2-git-send-email-clabbe@baylibre.com>
 <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 10, 2018 at 07:16:56AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 à 21:41, Corentin Labbe a écrit :
> > Since setbits32/clrbits32 work on be32, it's better to remove ambiguity on
> > the used data type.
> 
> Wouldn't it be better to call them setbits_be32() / clrbits_be32() to 
> have something looking similar to in_be32() / ou_be32() ?
> 

I agree, I will update the patch.

Thanks
