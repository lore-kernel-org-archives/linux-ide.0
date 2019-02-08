From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] ata: add Buddha PATA controller driver
Date: Fri, 8 Feb 2019 06:33:16 -0700
Message-ID: <f5019eaf-6f66-1971-3593-381664b55f65@kernel.dk>
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
 <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
 <420634d6-c14f-8380-0980-548fc4740474@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <420634d6-c14f-8380-0980-548fc4740474@physik.fu-berlin.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2/8/19 4:38 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 2/7/19 1:20 PM, Bartlomiej Zolnierkiewicz wrote:
>> Add Buddha PATA controller driver. It enables libata support for
>> the Buddha, Catweasel and X-Surf expansion boards on the Zorro
>> expansion bus.
>>
>> Module removal is currently unsupported (the old IDE's buddha
>> driver also doesn't support it).
>>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v2:
>> - added Tested-by from John
> 
> It's a bit confusing, but my primary name is Adrian, despite being
> the third one. So if this ends in a changelog, please change this
> to "- added Tested-by from Adrian".

The stuff below the --- line will not make it into the git log.

-- 
Jens Axboe
