From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 16:15:44 +0200
Message-ID: <20160814141544.GA2351@kroah.com>
References: <20160813190340.GA29989@amd>
 <20160814092044.GA20392@amd>
 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
 <20160814100102.GA31847@amd>
 <CAGnHSEm-Gww1-bmqZMz6guFDnByUuCFiCLhdrK_LETBH3qcb1Q@mail.gmail.com>
 <CAGnHSEnXo8VRm5Y6S6axpe-hG6an8ceujLajbZmxbGGDnCGh2w@mail.gmail.com>
 <alpine.DEB.2.02.1608140322400.9045@nftneq.ynat.uz>
 <20160814112958.GA20778@kroah.com>
 <20160814120327.GA8292@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160814120327.GA8292@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Lang <david@lang.hm>, Tom Yan <tom.ty89@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, james harvey <jamespharvey20@gmail.com>, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-ide@vger.kernel.org

On Sun, Aug 14, 2016 at 02:03:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > I have no idea how "SATA before USB" had been done in the past (if it
> > > > > was ever a thing in the kernel), but that has not been the case since
> > > > > at least v3.0 AFAIR.
> > > > > 
> > > > > > 
> > > > > > People may not run udev, and you can't use /dev/disk/by-id on kernel
> > > > > > command line.
> > > > > > 
> > > > > 
> > > > > No, but you can always use root=PARTUUID=, that's built into the
> > > > > kernel. (root=UUID= requires udev or so though).
> > > > 
> > > > Silly me. root=UUID= has nothing to do with udev, but `blkid` in
> > > > util-linux. At least that's how it's done in Arch/mkinitcpio.
> > > 
> > > The rule is "don't break working systems", not "but we are allowed to break
> > > systems, see it says here not to depend on this"
> > > 
> > > Drive ordering has been stable since the 0.1 kernel [1]
> > 
> > Drive probing order of USB has always been non-deterministic, so while I
> > agree that it is not good to break existing systems at all, perhaps this
> > is on the edge of what works vs. doesn't work?
> 
> Yeah, USB order is known to be random. But root=/dev/sda (when sda is
> on SATA) is very old, and it would be good to keep it.
> 
> > I know my USB drives always seem to come up in random order, which is
> > why tools like udev were invented :)
> > 
> > > It takes a lot longer to detect USB drives, why in the world would they be
> > > detected before hard-wired drives?
> > 
> > Depends, some hard-wired drives take much longer to find than USB ones.
> > 
> > That being said, it would be great if the original reporter could use
> > 'git bisect' and let the linux-usb and linux-scsi mailing list know what
> > the offending patch is, and we can take it from there.
> 
> Original reporter is me :-(.
> 
> Yes, I can do bisect, if required. I'd like some kind of confirmation
> that it happens on other systems...

Please use git-bisect, you are the first one reporting this.

thanks,

greg k-h
