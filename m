From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Tue, 03 Apr 2012 11:50:57 +1000
Message-ID: <4F7A5781.3000507@gmail.com>
References: <4F7418E7.4060500@metasoft.pl> <4F741AB1.4000107@metasoft.pl> <201203302018.43681.arnd@arndb.de> <4F795AD1.4070101@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60386 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2DCBvG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2012 21:51:06 -0400
Received: by obbtb18 with SMTP id tb18so2893799obb.19
        for <linux-ide@vger.kernel.org>; Mon, 02 Apr 2012 18:51:05 -0700 (PDT)
In-Reply-To: <4F795AD1.4070101@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, hsweeten@visionengravers.com, Sergei Shtylyov <sshtylyov@mvista.com>, joao.ramos@inov.pt

On 02/04/12 17:52, Rafal Prylowski wrote:

> On 2012-03-30 22:18, Arnd Bergmann wrote:
>>> +static u16 ep93xx_pata_read(struct ep93xx_pata_data *drv_data,
>>> +			    void *addr_io,
>>> +			    const struct ata_timing *t)
>>> +{
>>> +	unsigned long addr = (unsigned long) addr_io & 0x1f;
>>> +	void __iomem *base = drv_data->ide_base;
>>> +	u16 ret;
>>> +
>>> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
>>> +	ndelay(t->setup);
>>> +	writel(IDECtrl_DIOWn | addr, base + IDECtrl);
>>
>> The pointer arithmetic that you do here on addr_io looks really evil.
>> Basically your registers are indirect and cannot be accessed through
>> pointer dereference. Maybe you should not be trying to do that then
>> and not use the ata_port->ioaddr structure.
> 
> Yes, I already prepared a version of the driver in which IDE register
> addresses are coded as enums instead of using ata_port->ioaddr structure. 
> I will post updated version, when I get feedback from Ryan if enums
> or defines are preferred.

I would prefer defines, simply because it looks odd having an enum which
has multiple names defined to the same value, and most drivers tend to
use defines rather than enums for registers. It's not a big deal though,
and certainly not a show stopper.

~Ryan
