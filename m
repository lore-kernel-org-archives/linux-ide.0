From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
Date: Mon, 24 Sep 2018 21:08:04 +0200
Message-ID: <b87baa02-66e7-b855-478a-6d0bb4d39bad@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
