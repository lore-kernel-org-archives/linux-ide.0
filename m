From: starlight@binnacle.cx
Subject: Re: unexpected downspeed of AHCI controller on Intel   
  Seaburg 5400
Date: Tue, 18 Nov 2008 21:06:58 -0500
Message-ID: <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
 <4923743A.2050903@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.binnacle.cx ([74.95.187.105]:49201 "EHLO mx.binnacle.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbYKSCSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 21:18:33 -0500
Received: from geileis.binnacle.cx (geileis [172.29.87.12])
	by mx.binnacle.cx (envelope-from <starlight@binnacle.cx>)
	(8.14.1/8.14.1) with ESMTP id mAJ2IWmD030547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 21:18:32 -0500
In-Reply-To: <4923743A.2050903@shaw.ca>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
 <4923743A.2050903@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

At 20:04 11/18/2008 -0600, Robert Hancock wrote:
>It doesn't necessarily mean anything that it supports SATA II, that's=20
>just a revision of the spec and it defines support for 3 Gbps, but=20
>doesn't require it.

Wasn't precise enough in my statement.  The Intel
datasheet says it supports 3.0 Gbps:

http://download.intel.com/design/chipsets/datashts/31308201.pdf

5.18 SATA Host Controller (D31:F2)

The Intel=AE 631xESB/632xESB I/O Controller Hub has an integrated=20
SATA host controller that supports independent DMA operation on=20
six ports and supports data transfer rates of up to 3.0 Gb/s=20
(300 MB/s). . .

-----

The Seaburg 5400 is the absolute latest server chipset
with such fancy features as DCA.  Hard to believe that
Intel would not support 3 Gbps.

Is it possible for the BIOS to tell the chip to not negogiate=20
above 1.5 Gbps?  I'm wondering if HP might have done this to=20
prevent the bug below from happening.  If so it would be
nice for the driver to put it back to 3 Gbps.

http://www.intel.com/Assets/PDF/specupdate/313075.pdf

46. PxSERR errors are logged during BIOS initialization when=20
running at 3Gbps on a small percentage of parts Problem: This=20
failure signature has only been seen on a few Intel=AE=20
631xESB/632xESB I/O Controller Hub parts and only happens when=20
devices are running at 3Gbps. During BIOS boot up as the SATA=20
controller is initialized, PxSERR errors are logged. Error bits=20
1, 10, and 19 are set which are recovered data integrity error,=20
protocol error, and 10b to 8b decode error. These bits are set=20
in between BIOS postcode 423c and 503c. Some of these failing=20
parts on certain platforms will hang at postcode 0x75 . Affects=20
SATA ports.

Implication: May hang some operating systems\plaforms during=20
boot up. Intel=AE 631xESB/632xESB I/O Controller Hub Specification=20
Update 29

Errata
Workaround: NA.
Status: Fixed

