From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/14] ata: ahci-platform: add reset control support
 except for existing drivers
Date: Wed, 22 Aug 2018 11:27:18 +0200
Message-ID: <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 22-08-18 09:36, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing drivers
> set 0 to this flags.
> 
> This series solves the issue of the previous patch [1] that was already
> reverted [2].
> [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> 
> Kunihiko Hayashi (14):
>    ata: ahci-platform: add reset control support and the flag to specify
>      using reset
>    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
>    ata: ahci_ceva: add second argument of ahci_platform_get_resources()
>    ata: ahci_da850: add second argument of ahci_platform_get_resources()
>    ata: ahci_dm816: add second argument of ahci_platform_get_resources()
>    ata: ahci_imx: add second argument of ahci_platform_get_resources()
>    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
>    ata: ahci_mvebu: add second argument of ahci_platform_get_resources()
>    ata: ahci_qoriq: add second argument of ahci_platform_get_resources()
>    ata: ahci_seattle: add second argument of
>      ahci_platform_get_resources()
>    ata: ahci_st: add second argument of ahci_platform_get_resources()
>    ata: ahci_sunxi: add second argument of ahci_platform_get_resources()
>    ata: ahci_tegra: add second argument of ahci_platform_get_resources()
>    ata: ahci_xgene: add second argument of ahci_platform_get_resources()

When you change a function prototype, you must also change all
the callers in a single commit, so that all intermediate commits
will compile without errors, otherwise you will break git bisect.

Otherwise this looks good.

I suggest you split this like this:

1) Add a flags argument to ahci_platform_get_resources(),
    without adding support for any flags yet, so this just
    changes the function prototype and passes 0 for the new
    flags argument *everywhere* without any other changes
2) Add support for a AHCI_PLATFORM_GET_RESETS flag, basically
    your current first patch, minus the prototype patches
3) A patch which passes AHCI_PLATFORM_GET_RESETS for the
    generic ahci_platform driver (so break this out of your
    first patch). Also describe in the commit message of this
    patch why / for which platforms this is necessary.

The idea of doing 3. separately is that we can easily revert
it in case of problems while keeping the core functionality
in place. Note I do not expect this to be necessary.

Regards,

Hans


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
