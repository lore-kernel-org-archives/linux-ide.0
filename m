From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Thu, 1 Nov 2018 17:53:11 +1300
Message-ID: <9b38c21f-5eab-3d12-ee83-2b9ae1289ea1@gmail.com>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <f881dd9d-b41f-9993-44fe-71db55fb679d@physik.fu-berlin.de>
 <eb6a751b-8df3-d35c-a744-19d017778c74@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb6a751b-8df3-d35c-a744-19d017778c74@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Adrian,

my fix is evidently incomplete - I just crashed elgar trying to remove 
the pata_buddha module, sorry. Must've done something silly.

So no, can't post a patch to add module_exit just yet.

Cheers,

	Michael


Am 31.10.2018 um 23:06 schrieb John Paul Adrian Glaubitz:
> Hi!
>
> On 10/25/18 9:38 PM, John Paul Adrian Glaubitz wrote:
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>
>> Michael wants to make some changes to the driver though, I think. He has access
>> to the Amiga 4000, in any case, so he can also test them.
>
> @Michael: Can you post an updated version of the driver, rebased for 4.19
>           and with your patch?
>
> Adrian
>
