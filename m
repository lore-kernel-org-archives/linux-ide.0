From: Tom Rini <tom.rini@gmail.com>
Subject: Re: 65fe1f0 (ahci: implement aggressive SATA...) fail to boot
Date: Wed, 24 Oct 2012 17:25:18 -0700
Message-ID: <CA+M6bXmMeY_M9GZ_9JRtMeT7T47SCcYchyz_-=C0RbnEGQCAjw@mail.gmail.com>
References: <20121021175717.GA3543@bill-the-cat>
	<43EB3AB3EEFE8D43B525F4D2EAF507E107EAB746@SCYBEXDAG03.amd.com>
	<CA+M6bXmLcAh_1dQN_y9cu3C+umvsKNTX57nYfTm2ZL2SMvMvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35844 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab2JYAZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 20:25:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so496807bkc.19
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 17:25:18 -0700 (PDT)
In-Reply-To: <CA+M6bXmLcAh_1dQN_y9cu3C+umvsKNTX57nYfTm2ZL2SMvMvWw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, Jeff Garzik <jgarzik@redhat.com>

On Wed, Oct 24, 2012 at 5:15 PM, Tom Rini <tom.rini@gmail.com> wrote:
> On Sun, Oct 21, 2012 at 9:52 PM, Huang, Shane <Shane.Huang@amd.com> wrote:
>> Tom,
>>
>>> I've got an Asus motherboard with:
>>> 00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
>>> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
>>> ...
>>> 02:00.0 SCSI storage controller: OCZ Technology Group, Inc. RevoDrive 3
>>> X2 PCI-Express SSD 240 GB (Marvell Controller) (rev 02)
>>>
>>> And with 65fe1f0 merged I no longer see all devices on the RevoDrive.
>>> Happy to provide whatever further information might be helpful.
>>
>> Can you give me the motherboard name and dmesg?
>
> I beat my kernel config into enough submission so that I could
> interact this early and it's the RevoDrive 3 X2 that's not showing all
> drives and thus failing.  The dmesg is at
> http://pastebin.com/ZcKK3Rb4

And to compare, 3.6.0  http://pastebin.com/HybBiQAE

-- 
Tom
