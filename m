From: "Mark Odell" <modell@netezza.com>
Subject: RE: sil24 vs. noapic: what does this mean?
Date: Wed, 20 Sep 2006 08:36:21 -0400
Message-ID: <4D87F853B8020F4888896B1507DC0F09B19B3A@mail2.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hudson.netezza.com ([12.148.248.137]:22844 "HELO
	mail2.netezza.com") by vger.kernel.org with SMTP id S1751196AbWITMgW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Sep 2006 08:36:22 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>


> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Eyal Lebedinsky
> Sent: Wednesday, September 20, 2006 5:31 AM
> To: list linux-ide
> Subject: sil24 vs. noapic: what does this mean?
> 
> At the office we are testing a new mobo and initially used 
> the onboard SATA controllers (an sata_nv and sil24).
> 
> Disks are Seagate Barracuda ES 750GB on Asus P5N-SLI-SE-DELUXE mobo.
> 
> We get regular failures on the sil24 attached disks. Changing 
> power supply had no effect. We then booted with 'noapic' and 
> not a single error today.
> 
> The errors are of this type (sorry, no logs were kept)
> 	status=0x50 { DriveReady SeekComplete }

Which of course is a "no error" status. The LSbit indicates an error
which is not set here. Is it possible interrupts are not working
correctly?
