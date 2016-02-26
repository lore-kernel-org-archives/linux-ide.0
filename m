From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: RE: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Fri, 26 Feb 2016 13:48:45 +0000
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E019B4@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <18251200.Xfr10N5eWq@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8540232.vQE3WQTD95@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E0117F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160223192942.GA6235@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223192942.GA6235@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>
List-Id: linux-ide@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, February 24, 2016 1:00 AM
> To: Anurag Kumar Vulisha
> Cc: Arnd Bergmann; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah Choudary
> Kalluri
> Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-
> tree
> 
> On Tue, Feb 23, 2016 at 03:29:55PM +0000, Anurag Kumar Vulisha wrote:
> > Hi Arnd,
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > Sent: Tuesday, February 23, 2016 3:51 PM
> > > To: Anurag Kumar Vulisha
> > > Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> > > ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah
> > > Choudary Kalluri
> > > Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
> > > device- tree
> > >
> > > On Tuesday 23 February 2016 05:58:32 Anurag Kumar Vulisha wrote:
> > > > >
> > > > > I don't know what is appropriate because I have no idea what
> > > > > Rxwatermark is good for. Can you try describing why we can't
> > > > > just set it to the correct value for everyone automatically?
> > > > >
> > > >
> > > > This RX watermark level sets the minimum number of free locations
> > > > within the RX FIFO .When the rx fifo level crosses the programmed
> > > > watermark level ,sata controller  will transmit HOLDS to the
> > > > device asking it
> > > to wait. This happens when dma reads the rx fifo data slower than
> > > the device is sending the data. Note that it can take some time for
> > > the HOLDs to get to the other end and in the time there must be
> > > enough room in the FIFO to absorb all data that could arrive from the
> device.
> > > > Currently we are using 0x40 for this value, which works fine with
> > > > all hardware designs  we are currently having. But hoping that
> > > > this value may vary for future silicon versions, I wanted to make
> > > > this as a configurable
> > > value. So for this reason I thought of moving it either to
> > > device-tree or making it as a module_param() property.
> > > >
> > >
> > > Ok, so if this depends on the silicon version, your initial approach
> > > would be better than the module_param.
> > >
> > > I would probably make this dependent on the compatible string
> > > instead, and have a table in the device driver that uses a specific
> > > value for each variant of the device, but either way should be fine.
> > >
> > > Having a separate property is most appropriate if for each hardware
> > > revision there is exactly one ideal value, while a table in the
> > > driver makes more sense if this takes a bit of tuning and the driver
> > > might choose to optimize it differently based on other constraints,
> > > such as its own interrupt handler implementation.
> > >
> >
> > Since we are  currently having one value in common for all the
> > hardware and also changing the rx water mark does not require any
> > changes other than vendor specific PTC register update , I think it
> > would be better  to  use device tree property for that rx watermark value.
> Doing this makes the updating of rx watermark value easy, if any changes
> required.
> >
> > In future, if any silicon version rx water mark value doesn't work
> > with the current versions, then  I will do as you said by maintaining
> > the table in device driver. But at present  I feel that single rx
> > watermark property in device tree would be enough, since it works with all
> the hardware versions we have.
> 
> If you currently have no reason to modify it now, then add it later when you
> actually have a use case.
>

This property may vary from board to board . It also depends on the phy reference clock
frequency which can be changed based on use case. So moving this property to device
tree will make it easy for the  user  to  configure  this property based on the requirement.

Thanks,
Anuarg Kumar V
