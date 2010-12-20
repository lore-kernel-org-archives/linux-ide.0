From: wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Tue, 21 Dec 2010 01:17:47 +0800
Message-ID: <AANLkTi=pKc6KcJeXhdBbqDJ45Gmfy0UVwgCucK6KLUz1@mail.gmail.com>
References: <1292769160-24420-1-git-send-email-wuzhangjin@gmail.com>
	<4D0F3BDA.7080404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56105 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab0LTRRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2010 12:17:48 -0500
In-Reply-To: <4D0F3BDA.7080404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Martin K. Petersen" <mkp@mkp.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

Hi, Sergei

On Mon, Dec 20, 2010 at 7:19 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 19-12-2010 17:32, Wu Zhangjin wrote:
>
>> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
>> variant), so, remove the dependency of X86_32 and fix the building
>> errors under the other platforms via only reserving the X86_32 speci=
fic
>> parts for X86_32.
>
>> pata_amd also supports cs5536 IDE controller, but this one saves abo=
ut
>> 33k for the compressed kernel image(vmlinuz for MIPS).
>
>> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
>> Signed-off-by: Chen Jie <chenj@lemote.com>
>> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>
> [...]
>
>> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
>> index 21ee23f..643488b 100644
>> --- a/drivers/ata/pata_cs5536.c
>> +++ b/drivers/ata/pata_cs5536.c
>> @@ -37,7 +37,17 @@
>> =A0#include<linux/delay.h>
>> =A0#include<linux/libata.h>
>> =A0#include<scsi/scsi_host.h>
>> +
>> +#ifdef CONFIG_X86_32
>> =A0#include<asm/msr.h>
>> +static int use_msr;
>> +module_param_named(msr, use_msr, int, 0644);
>> +MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function
>> (Default: 0)");
>> +#else
>> +#define rdmsr(x, y, z) do { } while (0)
>> +#define wrmsr(x, y, z) do { } while (0)
>> +#define use_msr 0
>> +#endif
>>
>> =A0#define DRV_NAME =A0 =A0 =A0"pata_cs5536"
>> =A0#define DRV_VERSION =A0 "0.0.7"
>
> =A0 I think you should increment the driver version too.
>

Will use 0.0.8 in the next revision of this patch.

With the version incrementation, can I get your "Acked-by:"?

Thanks & Regards,
Wu Zhangjin

> WBR, Sergei
>
