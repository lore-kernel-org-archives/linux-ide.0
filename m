From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
Date: Thu, 27 Sep 2018 19:00:03 +0200
Message-ID: <08866634-04fb-e8fe-08bf-003d6a982b5a@physik.fu-berlin.de>
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
 <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
 <4c590675-71dc-d7f1-b40f-3b0ee124082a@physik.fu-berlin.de>
 <2435240.vCYXG2Zeag@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2435240.vCYXG2Zeag@amdc3058>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej!

Any chance you had a chance working on the libata port of the Buddha
driver? The Amiga 4000 here is equipped with a Buddha and I'm happy
to help testing the driver:

root@elgar:~> lszorro
00: Phase 5 Digital Products CyberSCSI/Blizzard 1220
01: Village Tronic Ariadne Ethernet Card
02: individual Computers X-Surf 100 Z-II/ZIII Ethernet
03: individual Computers Buddha IDE Controller
04: Phase 5 Digital Products CyberVision 64
root@elgar:~>

Adrian

On 3/1/18 11:52 AM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, March 01, 2018 10:55:48 AM John Paul Adrian Glaubitz wrote:
>> Hello!
> 
> Hi,
> 
>> On 02/18/2018 05:18 PM, John Paul Adrian Glaubitz wrote:
>>> Is there any progress on this? Is it just the SDPX headers now that
>>> are missing?
>>
>> Would it be okay if re-send the patch with the SPDX headers added?
>>
>> Or can we get the patch merged, then I'll send a patch to add the
>> SPDX headers?
> 
> I'll post updated version later today, sorry for the delay (I've been
> busy with other things and the patch is not v4.16 material anyway).
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
