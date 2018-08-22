From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] ata: ahci-platform: add reset control support
 except for existing drivers
Date: Wed, 22 Aug 2018 15:33:31 +0200
Message-ID: <02526d3d-70cb-e22b-39bd-583d516ba639@redhat.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 22-08-18 14:13, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing SoC-dependent
> drivers set 0 to this flag.
> 
> This series solves the issue of the previous patch [1] that was already
> reverted [2].
> [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> 
> Changes since v1:
> - collect patches for each soc-dependent driver
> - separate into 3 patches not to affect existing code

Thanks, series looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> Kunihiko Hayashi (3):
>    ata: add an extra argument to ahci_platform_get_resources()
>    ata: libahci_platform: add reset control support
>    ata: ahci_platform: enable to get and control reset
> 
>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>   drivers/ata/ahci.h                                 |  1 +
>   drivers/ata/ahci_brcm.c                            |  2 +-
>   drivers/ata/ahci_ceva.c                            |  2 +-
>   drivers/ata/ahci_da850.c                           |  2 +-
>   drivers/ata/ahci_dm816.c                           |  2 +-
>   drivers/ata/ahci_imx.c                             |  2 +-
>   drivers/ata/ahci_mtk.c                             |  2 +-
>   drivers/ata/ahci_mvebu.c                           |  2 +-
>   drivers/ata/ahci_platform.c                        |  3 +-
>   drivers/ata/ahci_qoriq.c                           |  2 +-
>   drivers/ata/ahci_seattle.c                         |  2 +-
>   drivers/ata/ahci_st.c                              |  2 +-
>   drivers/ata/ahci_sunxi.c                           |  2 +-
>   drivers/ata/ahci_tegra.c                           |  2 +-
>   drivers/ata/ahci_xgene.c                           |  2 +-
>   drivers/ata/libahci_platform.c                     | 35 ++++++++++++++++++----
>   include/linux/ahci_platform.h                      |  4 ++-
>   18 files changed, 49 insertions(+), 21 deletions(-)
> 
