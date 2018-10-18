From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Fri, 19 Oct 2018 11:40:48 +1300
Message-ID: <ed8cb7a4-9066-2c90-e000-7b2881e136c4@gmail.com>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <113f6584-0645-3484-2847-627e8d17b9b4@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <113f6584-0645-3484-2847-627e8d17b9b4@physik.fu-berlin.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Adrian,

module built and loaded fine (no need to build a new kernel for this). 
Can't unload the module however (-EBUSY).

You'll have to reboot elgar to reload the module, I'm afraid.

Cheers,

     Michael



On 19/10/18 01:32, John Paul Adrian Glaubitz wrote:
> Hi!
>
> On 10/18/18 2:29 PM, Bartlomiej Zolnierkiewicz wrote:
>> John, please test if possible..
> Yes, will test ASAP. @Michael: Can you build an updated kernel from your
> tree for elgar and copy it over. I'll make sure to test it and also
> hook up an IDE drive for testing.
>
> Adrian
>
