From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 10:04:03 +0800
Message-ID: <44347713.9000408@tw.ibm.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:27596 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751233AbWDFCEd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Apr 2006 22:04:33 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3624NFg026360
	for <linux-ide@vger.kernel.org>; Wed, 5 Apr 2006 22:04:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k36210OS273640
	for <linux-ide@vger.kernel.org>; Wed, 5 Apr 2006 20:01:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3624KSJ008162
	for <linux-ide@vger.kernel.org>; Wed, 5 Apr 2006 20:04:21 -0600
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: Tejun Heo <htejun@gmail.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Carlos Pardo wrote:
> The 3611 bridge does not support the ATAPI DMA direction bit in hardw=
are.(software support only) =20
>=20
> The 3811 bridge supports ATAPI DMA direction bit in both software and=
 hardware.
>=20
> The 646 chip is ancient and he should upgrade.  The behavior of this =
device is unknown since this part was EOL'd years ago.
>=20
>=20

Hi Carlos,

Does this mean that only the 3611 bridge needs the DMA_DIR bit set by h=
ost software, while 3811
can detect the ATAPI DMA direction by hardware and doesn't need the DMA=
_DIR bit?
(I guess that 3811 detects the direction by looking into the SCSI CDB. =
If the SCSI command is
unknown to it, 3811 still needs the DMA_DIR bit set by software.)
Is there anyway that we could detect whether the DMA_DIR needs to be se=
t by host software?
Is there anyway that we could detect whether the bridge is a 3611 or a =
3811 chip automatically?

Per Jeff's comment, there is a document on t13 (http://www.t13.org/docs=
2003/e03131r0.pdf).
The documents reads:
"Eg. =96 Word 50, bit 13: Set to 1 for devices that support DMAIN bit i=
n Features Register for Packet Command".
However, this looks more for the ATAPI device than for the bridge?
Also it looks not a t13 standard yet?
Can we use this word 50 to identify 3611/3811?

Thanks,

Albert

