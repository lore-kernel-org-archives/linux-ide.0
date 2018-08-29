From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] ata: libahci_platform: add reset control support
Date: Tue, 28 Aug 2018 19:34:18 -0500
Message-ID: <20180829003418.GA18849@bogus>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1534939983-16264-3-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534939983-16264-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 22, 2018 at 09:13:02PM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> However, according to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset make a path to occur double controls of resets.
> 
> The ahci_platform_get_resources() can get and control the reset
> only when the second argument includes AHCI_PLATFORM_GET_RESETS bit.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/ata/ahci.h                                 |  1 +
>  drivers/ata/libahci_platform.c                     | 31 ++++++++++++++++++----
>  include/linux/ahci_platform.h                      |  2 ++
>  4 files changed, 30 insertions(+), 5 deletions(-)
