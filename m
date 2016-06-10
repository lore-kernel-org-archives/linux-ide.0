From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Fri, 10 Jun 2016 13:07:08 -0500
Message-ID: <20160610180708.GA1598@rob-hp-laptop>
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-2-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160610060021.12382-2-linz@li-pro.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 10, 2016 at 07:59:57AM +0200, Stephan Linz wrote:
> Cc: Joseph Jezak <josejx@gentoo.org>
> Cc: J=F6rg Sommer <joerg@alea.gnuu.de>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>  Documentation/devicetree/bindings/leds/common.txt    | 3 ++-
>  Documentation/devicetree/bindings/leds/leds-gpio.txt | 4 ++--
>  Documentation/laptops/asus-laptop.txt                | 2 +-
>  Documentation/leds/leds-class.txt                    | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)

I'm not copied on the kernel change, but as long as the kernel still=20
handles ide-disk as you indicated:

Acked-by: Rob Herring <robh@kernel.org>
