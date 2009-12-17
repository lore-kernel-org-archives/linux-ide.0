From: Romain Kubany <rkubany@ikoula.com>
Subject: RE: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 13:07:44 +0100
Message-ID: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB31D@HMCEXMBX01CLUS.hmcikoula.com>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com>
 <19241.63911.160765.909812@pilspetsen.it.uu.se>
 <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com>
 <4B2A1008.9070202@garzik.org> <4B2A1E9E.30009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hmcexedge01.ikoula.com ([78.24.135.21]:52588 "EHLO
	mail.hmc.ikoula.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753265AbZLQMHs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 07:07:48 -0500
In-Reply-To: <4B2A1E9E.30009@garzik.org>
Content-Language: fr-FR
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Here it is under the 2.6.28 :

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       Virtual HD
        Serial Number:
        Firmware Revision:  1.1.0
Standards:
        Likely used: 2
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      16
        sectors/track   63      255
        --
        bytes/track: 65024      bytes/sector: 512
        CHS current addressable sectors:  267382800
        LBA    user addressable sectors:  267382800
        device size with M =3D 1024*1024:      130558 MBytes
        device size with M =3D 1000*1000:      136899 MBytes (136 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 64.0kB
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max =3D 128 Current =3D 128
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=3D333ns  IORDY flow control=3D=
120ns


-----Message d'origine-----
De=A0: Jeff Garzik [mailto:jgpobox@gmail.com] De la part de Jeff Garzik
Envoy=E9=A0: jeudi 17 d=E9cembre 2009 13:06
=C0=A0: Romain Kubany
Cc=A0: Mikael Pettersson; linux-kernel@vger.kernel.org; linux-ide@vger.=
kernel.org
Objet=A0: Re: Possible regression of LBA48 support for piix

On 12/17/2009 06:03 AM, Jeff Garzik wrote:
> On 12/17/2009 05:04 AM, Romain Kubany wrote:
>> Here is the new kernel config file : http://pastebin.com/f65fd472b
>
> I would definitely be interested in seeing the 'dmesg' output for
> libata, and results from a more recent kernel.

Also, what does 'hdparm -I /dev/XXXX' output look like?

	Jeff




