From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ata: ahci: add support for DaVinci DM816 SATA
 controller
Date: Fri, 24 Mar 2017 11:40:42 -0400
Message-ID: <20170324154042.GD21525@htj.duckdns.org>
References: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
 <1489489491-14195-3-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489489491-14195-3-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 14, 2017 at 12:04:51PM +0100, Bartosz Golaszewski wrote:
> This SATA controller is quite similar to the one present on the DA850
> SoC, but the PHY configuration is different and it supports two HBA
> ports.
> 
> The IP suffers from the same PMP issue the DA850 does - if we enable
> PMP but don't use it - softreset fails. Appropriate workaround was
> implemented in this driver as well.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
