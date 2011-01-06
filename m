From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Thu, 6 Jan 2011 14:43:08 +0800
Message-ID: <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<4D24B53C.4020009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1AFGnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 01:43:11 -0500
Received: by fxm20 with SMTP id 20so15763883fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 22:43:09 -0800 (PST)
In-Reply-To: <4D24B53C.4020009@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

2011/1/6 Jeff Garzik <jgarzik@pobox.com>:
> On 01/05/2011 12:43 AM, mkl0301@gmail.com wrote:
>>
>> From: Mac Lin<mkl0301@gmail.com>
>>
>> v2:
>> =A0- Switch ahci_platform to module device table matching to add SoC
>> specific support
>>
>> v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
>> =A0- Add CNS3xxx SoC specific AHCI support
>>
>> This patchset is based on linux-2.6.37-rc2
>>
>> Mac Lin (3):
>> =A0 =A0 =A0 ahci_platform: rename to ahci_pltfm, but keep the origin=
al module
>> name
>> =A0 =A0 =A0 ahci_pltfm: switch to module device table matching
>> =A0 =A0 =A0 ahci_platform: add support for CNS3xxx SoC devices
>>
>> =A0arch/arm/mach-cns3xxx/devices.c | =A0 =A02 +-
>> =A0drivers/ata/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 ++
>> =A0drivers/ata/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +-
>> =A0drivers/ata/ahci_cns3xxx.c =A0 =A0 =A0| =A0 62 +++++++++++
>> =A0drivers/ata/ahci_platform.c =A0 =A0 | =A0197
>> ------------------------------------
>> =A0drivers/ata/ahci_pltfm.c =A0 =A0 =A0 =A0| =A0212
>> +++++++++++++++++++++++++++++++++++++++
>> =A0drivers/ata/ahci_pltfm.h =A0 =A0 =A0 =A0| =A0 19 ++++
>> =A07 files changed, 309 insertions(+), 199 deletions(-)
>> =A0create mode 100644 drivers/ata/ahci_cns3xxx.c
>> =A0delete mode 100644 drivers/ata/ahci_platform.c
>> =A0create mode 100644 drivers/ata/ahci_pltfm.c
>> =A0create mode 100644 drivers/ata/ahci_pltfm.h
>
> It is overkill to rename the entirety of ahci_platform just for one o=
verride
> function.
> This sort of thing I would have expected to be added directly to
> ahci_platform.c.
It might be overkill for only one controller. but it is more clean and
readable to have different SoC specific changes in separate files,
especially when more SoCs need to make similar changes.

I will add them directly to ahci_platform.c if you insist.

Best Regards,
Mac Lin
