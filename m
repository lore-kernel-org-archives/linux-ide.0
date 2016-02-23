From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Tue, 23 Feb 2016 13:29:42 -0600
Message-ID: <20160223192942.GA6235@rob-hp-laptop>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <18251200.Xfr10N5eWq@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8540232.vQE3WQTD95@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E0117F@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9825E0117F-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Srikanth Vemula <svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 23, 2016 at 03:29:55PM +0000, Anurag Kumar Vulisha wrote:
> Hi Arnd,
> 
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > Sent: Tuesday, February 23, 2016 3:51 PM
> > To: Anurag Kumar Vulisha
> > Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> > ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah Choudary
> > Kalluri
> > Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-
> > tree
> > 
> > On Tuesday 23 February 2016 05:58:32 Anurag Kumar Vulisha wrote:
> > > >
> > > > I don't know what is appropriate because I have no idea what
> > > > Rxwatermark is good for. Can you try describing why we can't just
> > > > set it to the correct value for everyone automatically?
> > > >
> > >
> > > This RX watermark level sets the minimum number of free locations
> > > within the RX FIFO .When the rx fifo level crosses the programmed
> > > watermark level ,sata controller  will transmit HOLDS to the device asking it
> > to wait. This happens when dma reads the rx fifo data slower than the device
> > is sending the data. Note that it can take some time for the HOLDs to get to
> > the other end and in the time there must be enough room in the FIFO to
> > absorb all data that could arrive from the device.
> > > Currently we are using 0x40 for this value, which works fine with all
> > > hardware designs  we are currently having. But hoping that this value
> > > may vary for future silicon versions, I wanted to make this as a configurable
> > value. So for this reason I thought of moving it either to device-tree or
> > making it as a module_param() property.
> > >
> > 
> > Ok, so if this depends on the silicon version, your initial approach would be
> > better than the module_param.
> > 
> > I would probably make this dependent on the compatible string instead, and
> > have a table in the device driver that uses a specific value for each variant of
> > the device, but either way should be fine.
> > 
> > Having a separate property is most appropriate if for each hardware revision
> > there is exactly one ideal value, while a table in the driver makes more sense
> > if this takes a bit of tuning and the driver might choose to optimize it
> > differently based on other constraints, such as its own interrupt handler
> > implementation.
> > 
> 
> Since we are  currently having one value in common for all the hardware and also changing
> the rx water mark does not require any changes other than vendor specific PTC register update ,
> I think it would be better  to  use device tree property for that rx watermark value. Doing
> this makes the updating of rx watermark value easy, if any changes required.
> 
> In future, if any silicon version rx water mark value doesn't work with the current versions,
> then  I will do as you said by maintaining the table in device driver. But at present  I feel
> that single rx watermark property in device tree would be enough, since it works with all the
> hardware versions we have.

If you currently have no reason to modify it now, then add it later when 
you actually have a use case.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
