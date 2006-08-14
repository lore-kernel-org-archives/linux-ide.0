From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Mon, 14 Aug 2006 14:31:00 +0800
Message-ID: <44E018A4.3000907@tw.ibm.com>
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <200608100847.00837.r.brandstaedter@eunet.at> <44DAE22E.3050909@tw.ibm.com> <200608101056.06254.r.brandstaedter@eunet.at>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:222 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751893AbWHNGbR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 02:31:17 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7E6VHHG022773
	for <linux-ide@vger.kernel.org>; Mon, 14 Aug 2006 02:31:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7E6VGsk218364
	for <linux-ide@vger.kernel.org>; Mon, 14 Aug 2006 00:31:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7E6VGhp011457
	for <linux-ide@vger.kernel.org>; Mon, 14 Aug 2006 00:31:16 -0600
In-Reply-To: <200608101056.06254.r.brandstaedter@eunet.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r.brandstaedter@gmx.at
Cc: albertl@mail.com, linux-ide@vger.kernel.org, Unicorn Chang <uchang@tw.ibm.com>

Reinhard Brandst=E4dter wrote:
> On Thursday 10 August 2006 09:37, Albert Lee wrote:
>=20
>>Reinhard Brandst=E4dter wrote:
>>
>>>On Tuesday 16 May 2006 14:57, Albert Lee wrote:
>>>
>>>>Reinhard has a Plextor PX-712SA + svia.
>>>>Maybe he can also help to check whether the patch fixes the problem=
 on
>>>>his box.
>>>
>>>What I finally ended up with was solving the problem on the hardware
>>>side:
>>>
>>>The Plextor PX-712SA is a normal ATA device wich a IDE:SATA adapter
>>>plugged in at the back. I openend the DVDR Device (2 srews at the ba=
ck)
>>>repoved the adapter (1 screw) and then u get the normal IDE Interfac=
e
>>>(with master/slave jumpers, audio interface and normal ower plug). Y=
ou
>>>can use this device on an normal IDE interface then. Works perfect f=
or
>>>me, maybe the 716SA Drive is similar
>>>This was the only solution that fixed the problem for me, any submit=
ted
>>>kernel patches didn't work.
>>
>>I'm curious what's the PATA-to-SATA bridge chip used on the Plextor
>>PX-712SA. (Maybe it is not compatible with the VIA chip.)
>>Could you please check the IC on the IDE-SATA adapter?
>=20
>=20
> On the IC it reads:
> 88SA8040-TBC
> AP039208.3
> 0432 B0S
>=20
> I also attached a picture of the IC.
>=20

Hi Reinhard,

It's a Marvell 88SA8040. I have a Marvell 88SA8040 bridge at hand and
the bridge has been tested with SiI 3112 and it works ok with SiI 3112
and several CD-ROM drives.

Don't know whether the Marvell 88SA8040 works with SVIA.
Unicorn (on the cc list) has a VIA VT6421 SATA adapter. Will try
connecting the Marvell 88SA8040 with the VIA VT6421 and see if it works=
=2E

--
albert



