From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Tue, 19 Jan 2010 11:34:46 +0200
Message-ID: <4B557CB6.2060204@pardus.org.tr>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com> 	<4B331771.3090309@kernel.org> <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com> <4B532CB7.4060005@pardus.org.tr> <4B5575C8.4030205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:53559 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0ASJer (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 04:34:47 -0500
In-Reply-To: <4B5575C8.4030205@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@emory.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
>=20
> On 01/18/2010 12:28 AM, Ozan =C3=87a=C4=9Flayan wrote:
>> [    9.769407] ata1: nv_mode_filter: 0x739f&0x739f->0x739f, BIOS=3D0=
x7000 (0xc000c700) ACPI=3D0x701f (60:600:0x13)                         =
                        =20
>> [    9.775326] ata1.00: configured for UDMA/33                      =
           =20
>> [    9.775408] ata1.00: TEST_UNIT_READY failed (err_mask=3D0x2)     =
           =20
>=20
> Hmmm... err_mask=3D0x2 is HSM error.  Strange.  Does the attached pat=
ch
> make any difference?

Hi,

He reported back that after a few reboots its now working correctly. Ac=
tually the behaviour is a little bit
random as he succesfully installed the OS from a CD without losing its =
DVD drive.

I'll keep a patched kernel and send to him for testing if the bug reapp=
ears.

Thanks,
