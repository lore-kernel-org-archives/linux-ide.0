From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Thu, 21 May 2015 15:26:10 -0700
Message-ID: <CAN8TOE-eQF1QGSYTm12ryWy868jfJ+B1XUbSgpm9v275rCaFTQ@mail.gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
	<1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
	<CAOMZO5DtNa2-bgdGmiiJM4JZ7MHz2THSsNMwT=9oWO1ThNu2KA@mail.gmail.com>
	<20150521222059.GM4914@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33546 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbbEUW0L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 18:26:11 -0400
In-Reply-To: <20150521222059.GM4914@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kevin Cernekee <cernekee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 21, 2015 at 3:20 PM, Tejun Heo <tj@kernel.org> wrote:
> On Thu, May 21, 2015 at 07:16:07PM -0300, Fabio Estevam wrote:
>> On Tue, May 12, 2015 at 8:28 PM, Brian Norris
>> <computersforpeace@gmail.com> wrote:
>>
>> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
>> > +       ahci = devm_ioremap_resource(&pdev->dev, res);
>> > +       if (IS_ERR(ahci))
>> > +               return 0;
>>
>> You should propagate 'return PTR_ERR(ahci)' instead.
>
> Brian, can you please update the patch?

Note how the function brcm_ahci_get_portmask() is used. In brcm_ahci_probe():

        priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
        if (!priv->port_mask)
                return -ENODEV;

I could try to change the return semantics if really needed. Or I
could add some comments on brcm_ahci_get_portmask() to note its return
semantics. Or I could just leave the driver as-is. Your call.

Brian
