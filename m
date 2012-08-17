From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH 2/2] ahci_platform: add custom hard reset for Calxeda
 ahci ctrlr
Date: Fri, 17 Aug 2012 17:25:31 -0500
Message-ID: <502EC4DB.6020707@calxeda.com>
References: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com> <1345215111-11051-3-git-send-email-mark.langsdorf@calxeda.com> <502E7E7E.80101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp141.dfw.emailsrvr.com ([67.192.241.141]:38268 "EHLO
	smtp141.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934Ab2HQWZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 18:25:23 -0400
In-Reply-To: <502E7E7E.80101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "probinson@gmail.com" <probinson@gmail.com>, "jonathon@jonmasters.org" <jonathon@jonmasters.org>, "dmarlin@redhat.com" <dmarlin@redhat.com>, Rob Herring <rob.herring@calxeda.com>

On 08/17/2012 12:25 PM, Jeff Garzik wrote:
> On 08/17/2012 10:51 AM, Mark Langsdorf wrote:
>> Calxeda highbank SATA phy has intermittent problems bringing up a link
>> with Gen3 drives. Retrying the phy hard reset can work-around this issue,
>> but each reset also disables spread spectrum support. The reset function
>> also needs to reprogram the phy to enable spread spectrum support.
>>
>> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>   .../devicetree/bindings/arm/calxeda/combophy.txt   |   17 ++
>>   .../devicetree/bindings/ata/ahci-platform.txt      |    8 +
>>   arch/arm/boot/dts/highbank.dts                     |   17 ++
>>   drivers/ata/Makefile                               |    1 +
>>   drivers/ata/ahci.h                                 |   17 ++
>>   drivers/ata/ahci_platform.c                        |   88 ++++++++-
>>   drivers/ata/sata_highbank.c                        |  199 ++++++++++++++++++++
>>   7 files changed, 339 insertions(+), 8 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/calxeda/combophy.txt
>>   create mode 100644 drivers/ata/sata_highbank.c
>
> And the biggest issue...
> 
> 4) if you need all this code for workarounds, just create your own 
> libahci driver at that point.  make sata_highbank a real driver.

The frustrating bit is that we're nominally an AHCI compatible
controller except for the reset function and some kind of initialization
for the combophy iomem regions. The ata_port_operations already lets me
override just the reset function, and the ahci_probe() function has a
hook for the iomem initialization.

Is there any way I can inherit most of the existing ahci_platform
functions for suspend, resume, etc.? Because otherwise I'm just going to
duplicate the code and that feels unsatisfactory and seems unlikely to
get accepted anyway.

Would it be permissible to remove the statics from ahci_suspend,
ahci_resume, and ahci_remove so I could use them in my libahci driver?

--Mark Langsdorf
Calxeda, Inc.
