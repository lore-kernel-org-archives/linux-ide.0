From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Wed, 05 Jan 2011 13:15:24 -0500
Message-ID: <4D24B53C.4020009@pobox.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63484 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab1AESP3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 13:15:29 -0500
Received: by qyj19 with SMTP id 19so18468054qyj.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 10:15:28 -0800 (PST)
In-Reply-To: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On 01/05/2011 12:43 AM, mkl0301@gmail.com wrote:
> From: Mac Lin<mkl0301@gmail.com>
>
> v2:
>   - Switch ahci_platform to module device table matching to add SoC specific support
>
> v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
>   - Add CNS3xxx SoC specific AHCI support
>
> This patchset is based on linux-2.6.37-rc2
>
> Mac Lin (3):
>        ahci_platform: rename to ahci_pltfm, but keep the original module name
>        ahci_pltfm: switch to module device table matching
>        ahci_platform: add support for CNS3xxx SoC devices
>
>   arch/arm/mach-cns3xxx/devices.c |    2 +-
>   drivers/ata/Kconfig             |   11 ++
>   drivers/ata/Makefile            |    5 +-
>   drivers/ata/ahci_cns3xxx.c      |   62 +++++++++++
>   drivers/ata/ahci_platform.c     |  197 ------------------------------------
>   drivers/ata/ahci_pltfm.c        |  212 +++++++++++++++++++++++++++++++++++++++
>   drivers/ata/ahci_pltfm.h        |   19 ++++
>   7 files changed, 309 insertions(+), 199 deletions(-)
>   create mode 100644 drivers/ata/ahci_cns3xxx.c
>   delete mode 100644 drivers/ata/ahci_platform.c
>   create mode 100644 drivers/ata/ahci_pltfm.c
>   create mode 100644 drivers/ata/ahci_pltfm.h

It is overkill to rename the entirety of ahci_platform just for one 
override function.

This sort of thing I would have expected to be added directly to 
ahci_platform.c.

	Jeff




