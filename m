From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 6/7] drm: meson: use xxxsetbits32
Date: Mon, 24 Sep 2018 21:07:33 +0200
Message-ID: <9925d909-5f50-499d-744d-f59170e8899a@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Corentin,

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson DRM driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c      | 14 ++++---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 33 +++++++++--------
>  drivers/gpu/drm/meson/meson_plane.c     | 13 ++++---
>  drivers/gpu/drm/meson/meson_registers.h |  3 --
>  drivers/gpu/drm/meson/meson_venc.c      | 13 ++++---
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  4 +-
>  drivers/gpu/drm/meson/meson_viu.c       | 65 +++++++++++++++++----------------
>  drivers/gpu/drm/meson/meson_vpp.c       | 22 +++++------
>  8 files changed, 86 insertions(+), 81 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
