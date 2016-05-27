From: Andy Gross <andy.gross@linaro.org>
Subject: Re: sata_dwc_460ex driver
Date: Fri, 27 May 2016 13:15:03 -0500
Message-ID: <CAPBZ5Qd5MFP+7fyRaGgnmLNu3--J=+ogs0nCD4pfoU27gPE+cg@mail.gmail.com>
References: <57485F96.8010001@free.fr>
	<yw1xeg8n5v74.fsf@unicorn.mansr.com>
	<57487C33.4020306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34651 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbcE0SPF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2016 14:15:05 -0400
Received: by mail-yw0-f180.google.com with SMTP id c127so113294821ywb.1
        for <linux-ide@vger.kernel.org>; Fri, 27 May 2016 11:15:04 -0700 (PDT)
In-Reply-To: <57487C33.4020306@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Mans Rullgard <mans@mansr.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Lamparter <chunkeey@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kishon Vijay Abraham <kishon@ti.com>, Sebastian Frias <sf84@laposte.net>

On 27 May 2016 at 11:56, Mason <slash.tmp@free.fr> wrote:
> On 27/05/2016 18:20, M=C3=A5ns Rullg=C3=A5rd wrote:
>
>> Mason wrote:
>>
>>> I'm working on a SoC which embeds an IP block from Synopsys labeled
>>> Synopsys DesignWare Cores Serial ATA AHCI Core, aka DWC_ahsata
>>> (DWC SATA AHCI Host 6Gb/s AXI Interface).
>>>
>>> Would the sata_dwc_460ex driver support this DWC_ahsata hardware?
>>>
>>> I suppose I would also need to enable AHCI support, right?
>>>
>>> What is the difference between SATA_AHCI and SATA_AHCI_PLATFORM ?
>>>
>>> SATA_AHCI          =3D 971db06e09231
>>> SATA_AHCI_PLATFORM =3D 1c2a49f61785e
>>>
>>> If I understand correctly, SATA_AHCI is for platforms with a PCI bu=
s,
>>> while SATA_AHCI_PLATFORM is for other platforms. I probably want th=
e
>>> latter then?
>>>
>>> On the analog side, the SATA PHY is also made by Synopsys.
>>> Do I need to enable a specific driver?
>>> I didn't see anything relevant in drivers/phy
>>>
>>> (The documentation mentions 11 registers for tweaking the controlle=
r,
>>> but maybe it's the boot-loader's job to set this up correctly?)
>>
>> The sata_dwc_460ex driver can be made to work with the tango3/4 chip=
s.
>
> I'm talking about tango5. It's not the same controller as tango3/4.
> (They use different Synopsys DesignWare controllers.)
>
>> You need a dmaengine driver (I've written one for tango3, needs slig=
ht
>> tweaking for tango4) and some additions to the SATA driver to handle=
 the
>> DMA glue logic (I have unpublished code for this as well).  There ar=
e a
>> bunch of fixes for the SATA driver currently in linux-next, and I wa=
s
>> planning to take another look at supporting tango3/4 once these hit
>> mainline (4.7-rc1 most likely).
>
> FWIW, it seems like tango4 is low-priority internally ATM.
>
>> A driver for the PHY is probably a good idea, even if the boot loade=
r
>> does some configuration, since this allows it to be powered down whe=
n
>> not in use.
>
> How come there are so few phy drivers in drivers/phy if most devices
> would typically require one?

Short answer is that the generic phy framework is fairly recent (~3
years old).  A lot of phys are stuck off in other places like
drivers/usb/phy.  At least that's my take on it.


Regards,

Andy Gross
