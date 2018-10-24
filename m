From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/7] ata: ahci_sunxi: use
 xxxsetbitsi_le32 functions
Date: Wed, 24 Oct 2018 10:57:49 +0300
Message-ID: <83472722-c7e7-820f-b97f-37016ff32893@cogentembedded.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
Reply-To: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBC6MFNV32EFRBBGMYDPAKGQEWT2T2BQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1540366553-18541-5-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Gilles.Muller-L2FTfq7BK8M@public.gmane.org, Julia.Lawall-L2FTfq7BK8M@public.gmane.org, agust-ynQEQJNshbs@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, michal.lkml-yyZNWGI4GtDR7s880joybQ@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nicolas.palix-wMUr/XMoy4A@public.gmane.org, oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello!

    Typo in the subject: s/xxxsetbitsi/xxxsetbits/.

On 24.10.2018 10:35, Corentin Labbe wrote:

> This patch converts ahci_sunxi to use xxxsetbits_le32 functions
>
> Signed-off-by: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
[...]

MBR, Sergei
