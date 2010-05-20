From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: SATA in Target Mode
Date: Thu, 20 May 2010 13:54:27 +0300
Message-ID: <AANLkTilI3OlFZRFMdsv21o0bWDd6fuWkcwB7AxyWGzkj@mail.gmail.com>
References: <AANLkTinSg70pTj2uwnHuB4xT1I88nNU06l080_m9vngl@mail.gmail.com>
	 <AANLkTimLUIShHybcy51NThd2gtkQxFtXWCyVY2iee_c6@mail.gmail.com>
	 <4BF40867.9000606@garzik.org>
	 <AANLkTimGGPVYlMy0ka3NIVZhawDEdjAMwLt96-jn6Bg6@mail.gmail.com>
	 <AANLkTilW_wrbrbzfLjbLb_QlIjfvP28-TIoSRTFakU4k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60884 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0ETKya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 06:54:30 -0400
Received: by wwb34 with SMTP id 34so135908wwb.19
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 03:54:28 -0700 (PDT)
In-Reply-To: <AANLkTilW_wrbrbzfLjbLb_QlIjfvP28-TIoSRTFakU4k@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jayaraman Thiruvady <jayaraman.tg@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, May 20, 2010 at 1:38 PM, Jayaraman Thiruvady
<jayaraman.tg@gmail.com> wrote:
> Hi Saeed,
>>
>> =C2=A0 =C2=A0I've implemented the target mode for the marvell sata c=
ontrollers
>> (supported by sata_mv.c), but that wasn't based on the libata driver=
,
>> it was done on marvell's in house driver (GPL), please let me know i=
f
>> you need reference code and information about the HW.
>>
> =C2=A0 =C2=A0 I would like try on the Marvell sata controller chip-se=
t (HW).
> Please let me know more details on hardware and its reference code.
> Thanks in advance.
Here is the functional spec of the kw soc, this soc includes the sata
controller, this device supported by the sata_mv.c libata driver.
http://www.marvell.com/products/processors/embedded/kirkwood/FS_88F6180=
_9x_6281_OpenSource.pdf


saeed
