From: "kefeng.wang" <kefeng.wang@linaro.org>
Subject: Re: [PATCH v6 0/3] ahci: add support for hisilicon sata
Date: Mon, 05 May 2014 20:05:54 +0800
Message-ID: <53677EA2.20004@linaro.org>
References: <1398416351-30567-1-git-send-email-kefeng.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46100 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587AbaEEMGD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2014 08:06:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so4025604pad.18
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2014 05:06:02 -0700 (PDT)
In-Reply-To: <1398416351-30567-1-git-send-email-kefeng.wang@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kefeng Wang <kefeng.wang@linaro.org>, Hans de Goede <hdegoede@redhat.com>, xuwei5@hisilicon.com

Hi Tejun, ping...

On 2014-4-25 16:59, Kefeng Wang wrote:
> change in v6:
> 1) type of host_flags changed from unsigned int to unsigned long,
>    fix the building warning and error. 
> 
> channge in v5:
> 1) drop AHCI_HFLAGS(...) from ahci_xgene.c and do use host_flags
>    in ahci_platform_init_host, it's my carelessness.
> 
> changes in v4:
> 1) add a dynamic host_flags parameter in ahci_platform_init_host
>    to make it more flexible, modify some driver to use new
>    way to pass host flags, suggested by Hans
> 
> changes in v3:
> 1) move NO_FBS chunk after YES_FBS, Tejun's suggestion
> 2) use ata_port_info pointer to avoid struct ata_port_info
>    on the stack twice
> 
> changes in v2:
> 1) make code more concise according to Hans's advice
> 
> Kefeng Wang (3):
>   ata: ahci: append new hflag AHCI_HFLAG_NO_FBS
>   libahci_platform: add host_flags parameter in
>     ahci_platform_init_host()
>   ahci: add support for Hisilicon sata
> 
>  .../devicetree/bindings/ata/ahci-platform.txt      |    3 ++-
>  drivers/ata/ahci.h                                 |    1 +
>  drivers/ata/ahci_da850.c                           |    3 ++-
>  drivers/ata/ahci_imx.c                             |    3 ++-
>  drivers/ata/ahci_platform.c                        |    9 ++++++++-
>  drivers/ata/ahci_st.c                              |    2 +-
>  drivers/ata/ahci_sunxi.c                           |    9 ++++++---
>  drivers/ata/ahci_xgene.c                           |    7 +++++--
>  drivers/ata/libahci.c                              |    5 +++++
>  drivers/ata/libahci_platform.c                     |    5 ++++-
>  include/linux/ahci_platform.h                      |    1 +
>  11 files changed, 37 insertions(+), 11 deletions(-)
> 

