From: Grozdan <neutrino8@gmail.com>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Fri, 5 Jun 2009 12:35:46 +0200
Message-ID: <c5bd819b0906050335i4e813887sc8f4d901da86a1aa@mail.gmail.com>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	 <4A25F688.9000407@gmail.com>
	 <c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
	 <20090603131407.57c490ed@lxorguk.ukuu.org.uk>
	 <c5bd819b0906030552w6f23185etb394f83c8b630e6@mail.gmail.com>
	 <20090603140140.491a8ea8@lxorguk.ukuu.org.uk>
	 <c5bd819b0906030639o5f9c34ffg500e132d3a0b5117@mail.gmail.com>
	 <c5bd819b0906040750w75e0389cod2a03b89ce838d1b@mail.gmail.com>
	 <20090605100505.41b3b818@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58204 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZFEKfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 06:35:47 -0400
In-Reply-To: <20090605100505.41b3b818@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hancockrwd@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2009/6/5 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> Adding more information. A user on the openSUSE forum which is tryin=
g
>> out openSUSE 11.2 milestone 2 (with kernel 2.6.30-rc6-git3) is havin=
g
>> the same problems. His computer is using the pata_amd driver instead
>> of pata_via like mine and he too gets limiting to UDMA33 during boot
>>
>> Link: http://forums.opensuse.org/pre-release-beta/415373-hd-speed.ht=
ml
>
> Different problem. However that Nvidia one it would be worth trying t=
his
> so that we just rely upon the ACPI/BIOS data for Nvidia.
>
> diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
> index 33a74f1..c9c5fad 100644
> --- a/drivers/ata/pata_amd.c
> +++ b/drivers/ata/pata_amd.c
> @@ -424,7 +424,7 @@ static struct ata_port_operations amd133_port_ops=
 =3D {
>
> =A0static const struct ata_port_operations nv_base_port_ops =3D {
> =A0 =A0 =A0 =A0.inherits =A0 =A0 =A0 =3D &ata_bmdma_port_ops,
> - =A0 =A0 =A0 .cable_detect =A0 =3D ata_cable_ignore,
> + =A0 =A0 =A0 .cable_detect =A0 =3D ata_cable_80wire,
> =A0 =A0 =A0 =A0.mode_filter =A0 =A0=3D nv_mode_filter,
> =A0 =A0 =A0 =A0.prereset =A0 =A0 =A0 =3D nv_pre_reset,
> =A0 =A0 =A0 =A0.host_stop =A0 =A0 =A0=3D nv_host_stop,
>

Hi Alan,

I've relayed your reply to the pata_amd user on the forum. As for my
case with pata_via, until this is fixed, is there any way to force it
to use a higher UDMA? Is there a flag that can be passed in, for
example, in /sys somewhere? hdparm fails to set a higher UDMA and I
looked at sdparm but don't see anything in it to increase UDMA...
