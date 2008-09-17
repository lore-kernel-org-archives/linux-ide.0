From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Recommended PCI Express or PCI-X SATA (Raid) Controller?
Date: Wed, 17 Sep 2008 15:36:50 +0100
Message-ID: <f4527be0809170736w4cf59a71j38588aea78d3f10a@mail.gmail.com>
References: <f4527be0809130200i23053c1m34855368bac129c7@mail.gmail.com>
	 <1221595291.23098.8.camel@zarvora>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:43329 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYIQOgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 10:36:52 -0400
Received: by ug-out-1314.google.com with SMTP id k3so452806ugf.37
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 07:36:50 -0700 (PDT)
In-Reply-To: <1221595291.23098.8.camel@zarvora>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Andrewartha <jamesa@daa.com.au>
Cc: linux-ide@vger.kernel.org, jim@jtan.com

On Tue, Sep 16, 2008 at 9:01 PM, James Andrewartha <jamesa@daa.com.au> wrote:
> On Sat, 2008-09-13 at 10:00 +0100, Andrew Lyon wrote:
>> I want to add a PCI Express or PCI-X SATA Controller to my system for
>> an additional 2 or 4 sata ports, however I am running Xen so I am
>> stuck with a older kernel version, gentoo xen 2.6.21 has proved to be
>> fairly stable on my hardware but I may attempt to upgrade to 2.6.25 if
>> necessary, can anybody recommend a pci-x or pci express sata
>> controller with 2 or 4 ports that has been well supported since at
>> least 2.6.21?
>>
>> I assumed that any real hardware raid device would be beyond my budget
>> but I might just be able to afford a Areca ICAe1210, has anybody used
>> Areca cards with older kernels?
>
> The Sil 3132 is a good 2-port PCIe controller, or the 3124 is 4 ports on
> PCI-X. Going up a bit, the supermicro AOC-USAS-S8i is an 8-port PCIe SAS
> controller based on the LSISAS1068E which has had a Linux driver for a
> while, but I don't know what the support for SATA drives on it in Linux
> is like.
>
> The Areca cards are good and have drivers for older kernels (2.6.18 if
> not earlier).
>
> James Andrewartha
>


Thanks for the info, I borrowed a PCIe Sil 3132 and also found a PCI
3112 in our spares, the 3112 was not detected by sata_sil when running
2.6.18-xen but I've since made my own Xen kernel based on
gentoo-sources-2.6.25-gentoo-r8 (2.6.25.15) and the Xen patches from
Opensuse 2.6.25, with a newer kernel both cards are detected and work
well, I may replace them with a single 3124 PCI-X in the near future.

I have noticed one very minor problem, I am using a Supermicro
SC743TQ-865-SQ case with CSE-SAS-743TQ SATA/SAS hotswap backplane and
X7DWA-N motherboard, 6 of the drives are connected to the onboard
SATA, 2 to the 3132 and the 3112 is used for SATA DVDROM+DVDRW, the
hot swap bays have two led's for each drive, activity and failure,
when the onboard SATA is initialized and the drives are detected the
led's in each bay flash red, they flash again when smartd is loaded
and then flash green for activity, the led's in the bays connected to
the 3132 do not flash at all.

The backplane http://www.supermicro.com/manuals/other/BPN-SAS-743TQ.pdf
can use I2C or SGPIO mode, I've left it on I2C (default) as the
motherboard only came with one SGPIO cable, although it does have two
ports.

What exactly is I2C/SGPIO used for with a hot swap backplane like this?

Perhaps the LED's only work when all 8 ports are connected to the same
controller?

Andy
