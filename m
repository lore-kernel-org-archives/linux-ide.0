From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] ahci_platform: add custom hard reset for Calxeda
 ahci ctrlr
Date: Fri, 17 Aug 2012 13:25:18 -0400
Message-ID: <502E7E7E.80101@pobox.com>
References: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com> <1345215111-11051-3-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37195 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472Ab2HQRZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:25:22 -0400
Received: by yhmm54 with SMTP id m54so4201921yhm.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:25:22 -0700 (PDT)
In-Reply-To: <1345215111-11051-3-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-ide@vger.kernel.org, probinson@gmail.com, jonathon@jonmasters.org, dmarlin@redhat.com, Rob Herring <rob.herring@calxeda.com>

On 08/17/2012 10:51 AM, Mark Langsdorf wrote:
> Calxeda highbank SATA phy has intermittent problems bringing up a link
> with Gen3 drives. Retrying the phy hard reset can work-around this issue,
> but each reset also disables spread spectrum support. The reset function
> also needs to reprogram the phy to enable spread spectrum support.
>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>   .../devicetree/bindings/arm/calxeda/combophy.txt   |   17 ++
>   .../devicetree/bindings/ata/ahci-platform.txt      |    8 +
>   arch/arm/boot/dts/highbank.dts                     |   17 ++
>   drivers/ata/Makefile                               |    1 +
>   drivers/ata/ahci.h                                 |   17 ++
>   drivers/ata/ahci_platform.c                        |   88 ++++++++-
>   drivers/ata/sata_highbank.c                        |  199 ++++++++++++++++++++
>   7 files changed, 339 insertions(+), 8 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/calxeda/combophy.txt
>   create mode 100644 drivers/ata/sata_highbank.c

This is an odd arrangement:

1) creates a sata_foo.c, which is not a driver but a library.

2) unconditionally burdens all ahci_platform users with Calxeda-specific 
code.

3) #ifndef CONFIG_ARCH_HIGHBANK code wrappers should be 'static inline'

And the biggest issue...

4) if you need all this code for workarounds, just create your own 
libahci driver at that point.  make sata_highbank a real driver.


