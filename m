From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA driver sata_sil24
Date: Fri, 23 Apr 2010 18:34:36 -0600
Message-ID: <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
References: <20100422083226.GA6018@crow.mawsonit.co.uk>
	 <4BD0203C.7010903@gmail.com>
	 <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com>
	 <20100422223309.GA1883@crow.mawsonit.co.uk>
	 <4BD1129E.6030104@gmail.com>
	 <20100423203446.GF1883@crow.mawsonit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37821 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363Ab0DXAei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 20:34:38 -0400
Received: by gwj19 with SMTP id 19so2995665gwj.19
        for <linux-ide@vger.kernel.org>; Fri, 23 Apr 2010 17:34:37 -0700 (PDT)
In-Reply-To: <20100423203446.GF1883@crow.mawsonit.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Mawson <richard@crow.mawsonit.co.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, Apr 23, 2010 at 2:34 PM, Richard Mawson
<richard@crow.mawsonit.co.uk> wrote:
> On Thu, Apr 22, 2010 at 09:23:10PM -0600, Robert Hancock wrote:
>> Hmm, that seems like this line in drivers/ata/sata_sil24.c:
>>
>> =A0 =A0 =A0 =A0 /* Set max read request size to 4096. =A0This slight=
ly increases
>> =A0 =A0 =A0 =A0 =A0* write throughput for pci-e variants.
>> =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 pcie_set_readrq(pdev, 4096);
>>
>> Can you try commenting out or deleting that line and rebuilding, and=
 see
>> if things work better? That's not really a solution, but if it worke=
d,
>> it would indicate there's something about the system configuration w=
ith
>> that converter card installed that explodes when trying to set the m=
ax
>> read request size. In that case can you post the output of "lspci -v=
v"
>> and the full dmesg boot log?
>
> Having put printk messages all over the driver, I see it currently lo=
cks up
> during this readl call:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear port RST */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D readl(port + PORT_CTRL_STAT);
>
> .. but as this is clearly later on from the previously mentioned stac=
k, I'm
> starting to suspect that this is failing in random places when talkin=
g across
> this pci-pcie bridge. Do you agree that this sounds plausible?

I suspect it's something like that - not sure what else could cause
things to explode at that point..

>
> I did attempt to get a crash dump, but failed to get any joy from usi=
ng the
> nmi watchdog to trigger the use of the debug kernel in this state.
>
> I will attempt using a different machine, hopefully tomorrow, but I h=
ave no
> native pcie machines so can't eliminate the pci-pcie bridge being at =
fault.
>
> Thanks for your help.
>
> --
> Richard Mawson
> Mawson IT Services
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkvSBGYACgkQEqu+mbnN8VKZTgCeMu3flpdyVdp7smp8qaaJPGIp
> 8h8AnReBz04O1NVYqD16zLnYcnN9NNHZ
> =3DbANg
> -----END PGP SIGNATURE-----
>
>
