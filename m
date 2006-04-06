From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 11:31:58 +0900
Message-ID: <44347D9E.8080107@gmail.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com> <44347713.9000408@tw.ibm.com> <44347A3D.1000609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:40068 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbWDFCcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 22:32:01 -0400
Received: by xproxy.gmail.com with SMTP id t10so34415wxc
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 19:32:00 -0700 (PDT)
In-Reply-To: <44347A3D.1000609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: albertl@mail.com, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Albert Lee wrote:
>> Per Jeff's comment, there is a document on t13=20
>> (http://www.t13.org/docs2003/e03131r0.pdf).
>> The documents reads:
>> "Eg. =96 Word 50, bit 13: Set to 1 for devices that support DMAIN bi=
t in=20
>> Features Register for Packet Command".
>> However, this looks more for the ATAPI device than for the bridge?
>> Also it looks not a t13 standard yet?
>> Can we use this word 50 to identify 3611/3811?
>=20
>=20
> DMADIR is in my copy of ATA-7...
>=20

Here's the relavant part from ATA8 draft.  It seems that the bridge is=20
supposed to mangle the IDENTIFY PACKET DEVICE result.  It's supposed to=
=20
nuke all DMA transfer mode information reported from the original devic=
e=20
and report supported modes from the view point of the bridge in bits=20
10:1 (which, BTW, should be all 1's).

The question is whether or not bridges implement this properly. I think=
=20
we can add a printk to word 62 and ask Jonathan to test it.

----

7.18.6.17 Word 62: DMADIR

ATAPI devices that use a serial ATA bridge chip for connection to a=20
serial ATA host may require use of the DMADIR bit to indicate transfer=20
direction for Packet DMA commands. Word 62 is used to indicate if such
support is required.

If bit 15 of word 62 is set to one, then DMADIR bit in the Packet=20
Command is required by the device for Packet DMA and Bits 2:0 of word=20
63, bits 15 and 8 in word 49, and bits 6:0 of word 88 shall be cleared=20
to 0,.

If bit 15 of word 62 is cleared to 0, DMADIR bit in the PACKET command=20
is not required. If bit 15 of word 62 is cleared to zero, then all bits=
=20
of word 62 shall be cleared to zero.

Bits (14:11) are reserved.

Bits (10:1) indicate DMA mode support. Since the DMADIR bit is only use=
d=20
for a Serial ATAPI device, all of these bits are set to 1.

--=20
tejun
