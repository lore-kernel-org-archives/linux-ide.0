From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v4 0/2] Add support for MediaTek AHCI SATA
Date: Sat, 26 Aug 2017 11:19:39 +0800
Message-ID: <1503717579.10648.9.camel@mtkswgap22>
References: <cover.1503018631.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:52785 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751662AbdHZDTr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Aug 2017 23:19:47 -0400
In-Reply-To: <cover.1503018631.git.ryder.lee@mediatek.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

Hi Tejun,

Just a gentle ping. I think others are okay with both :D

Thanks.

On Fri, 2017-08-18 at 09:13 +0800, Ryder Lee wrote:
> Hi,
> 
> This patch series add support for AHCI compatible SATA controller, and it is
> compliant with the ahci 1.3 and sata 3.0 specification. This driver is slightly
> different than ahci_platform.c (e.g., reset control, subsystem setting).
> 
> changes since v4:
> - update binding text: Instead of "soc-model", pick something checkpatch.pl understands
> 
> changes since v3:
> - update binding text: fix a typo and modify compatible strings.
> 
> changes since v2:
> - according to Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting reset lines").
>   replace devm_reset_control_get_optional() by devm_reset_control_get_optional_exclusive().
> 
> changes since v1:
> - update binding text: add missing "specifier pairs" descriptions.
> - fix kbuild test warning: fix the error handling.
> 
> Ryder Lee (2):
>   ata: mediatek: add support for MediaTek SATA controller
>   dt-bindings: ata: add DT bindings for MediaTek SATA controller
> 
>  Documentation/devicetree/bindings/ata/ahci-mtk.txt |  51 ++++++
>  drivers/ata/Kconfig                                |  10 ++
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_mtk.c                             | 196 +++++++++++++++++++++
>  4 files changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
>  create mode 100644 drivers/ata/ahci_mtk.c
> 


