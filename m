From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: RE: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Mon, 22 Feb 2016 10:53:11 +0000
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E00BD4@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <28916176.WDrPajhOPa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28916176.WDrPajhOPa@wuerfel>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>
List-Id: linux-ide@vger.kernel.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Sunday, February 21, 2016 4:05 AM
> To: Anurag Kumar Vulisha
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah Choudary
> Kalluri; Anurag Kumar Vulisha
> Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-
> tree
> 
> On Saturday 20 February 2016 18:48:22 Anurag Kumar Vulisha wrote:
> > index 7ca8b97..7e48dfc 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> > +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >
> >  Optional properties:
> >    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> > +  - ceva,rx-watermark: RX fifo water mark level for SATA controller.
> >
> >  Examples:
> >         ahci@fd0c0000 {
> > @@ -17,4 +18,5 @@ Examples:
> >                 interrupts = <0 133 4>;
> >                 clocks = <&clkc SATA_CLK_ID>;
> >                 ceva,broken-gen2;
> > +               ceva,rx-watermark = <0x40>;
> >         };
> >
> 
> How would a hardware integrator know which value is right for a particular
> SoC?
> 
> Could it be keyed off the hardware ID? Could the bootloader perhaps set an
> appropriate value in the AHCI_VEND_PTC register at boot time and the driver
> read the initial value from it?
> 
> From the description, it sounds like this is a policy decision rather than
> hardware description, and shouldn't really be in here.
> 

Thanks for reviewing the patch. Can I use module_param() for this watermark instead of reading it from devicetree or
doing it in bootloader. In bootloader we are initializing serdes controller for high speed devices. As a part of this initialization
we will be reseting all the high speed pheripherals which are using serdes, so SATA will also get resetted. Because of this
reason, can I use module_param() for Rxwatermark value  instead?

Thanks,
Anurag Kumar V
  
> 	Arnd
