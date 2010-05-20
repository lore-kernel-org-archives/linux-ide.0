From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: SATA in Target Mode
Date: Thu, 20 May 2010 13:15:12 +0300
Message-ID: <AANLkTimGGPVYlMy0ka3NIVZhawDEdjAMwLt96-jn6Bg6@mail.gmail.com>
References: <AANLkTinSg70pTj2uwnHuB4xT1I88nNU06l080_m9vngl@mail.gmail.com>
	 <AANLkTimLUIShHybcy51NThd2gtkQxFtXWCyVY2iee_c6@mail.gmail.com>
	 <4BF40867.9000606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56135 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 06:15:14 -0400
Received: by wwb34 with SMTP id 34so112926wwb.19
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 03:15:13 -0700 (PDT)
In-Reply-To: <4BF40867.9000606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jayaraman Thiruvady <jayaraman.tg@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Wed, May 19, 2010 at 6:48 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 05/19/2010 02:12 AM, Jayaraman Thiruvady wrote:
>>
>> Hi,
>>
>> =C2=A0 =C2=A0 =C2=A0 I am trying to make vdisk ( file disk ) to emul=
ate as a SATA
>> drive. To do so, i thought of making a SATA port to target mode and
>> cross wire it with another SATA port ( initiator) and by mapping the
>> SATA target mode port with vdisk, the SATA initiator must detect the
>> vdisk as some SATA device to perform further. Is such scenario doabl=
e?
>>
>> Is the place where i can find more details on how much scenario is
>> achievable and the details Marvell SATA support as target mode in
>> kernel-tree and its info supported chipsets?.
>
> Unfortunately, nobody's really worked on it, as far as I know.
>
> It would be great to see SATA target support, though.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Jeff
Jayaraman,
    I've implemented the target mode for the marvell sata controllers
(supported by sata_mv.c), but that wasn't based on the libata driver,
it was done on marvell's in house driver (GPL), please let me know if
you need reference code and information about the HW.

saeed
