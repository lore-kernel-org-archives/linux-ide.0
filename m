From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 13:29:58 +0200
Message-ID: <20160814112958.GA20778@kroah.com>
References: <20160813190340.GA29989@amd>
 <20160814092044.GA20392@amd>
 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
 <20160814100102.GA31847@amd>
 <CAGnHSEm-Gww1-bmqZMz6guFDnByUuCFiCLhdrK_LETBH3qcb1Q@mail.gmail.com>
 <CAGnHSEnXo8VRm5Y6S6axpe-hG6an8ceujLajbZmxbGGDnCGh2w@mail.gmail.com>
 <alpine.DEB.2.02.1608140322400.9045@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1608140322400.9045-UEhY+ZBZOcqqLGM74eQ/YA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lang <david-gFPdbfVZQbY@public.gmane.org>
Cc: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, james harvey <jamespharvey20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Aug 14, 2016 at 03:26:45AM -0700, David Lang wrote:
> On Sun, 14 Aug 2016, Tom Yan wrote:
> 
> > On 14 August 2016 at 18:07, Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On 14 August 2016 at 18:01, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> > > > 
> > > > Since SATA support was merged, certainly since v2.4, and from way
> > > > before /dev/disk/by-id existed.
> > > 
> > > I have no idea how "SATA before USB" had been done in the past (if it
> > > was ever a thing in the kernel), but that has not been the case since
> > > at least v3.0 AFAIR.
> > > 
> > > > 
> > > > People may not run udev, and you can't use /dev/disk/by-id on kernel
> > > > command line.
> > > > 
> > > 
> > > No, but you can always use root=PARTUUID=, that's built into the
> > > kernel. (root=UUID= requires udev or so though).
> > 
> > Silly me. root=UUID= has nothing to do with udev, but `blkid` in
> > util-linux. At least that's how it's done in Arch/mkinitcpio.
> > 
> 
> The rule is "don't break working systems", not "but we are allowed to break
> systems, see it says here not to depend on this"
> 
> Drive ordering has been stable since the 0.1 kernel [1]

Drive probing order of USB has always been non-deterministic, so while I
agree that it is not good to break existing systems at all, perhaps this
is on the edge of what works vs. doesn't work?

I know my USB drives always seem to come up in random order, which is
why tools like udev were invented :)

> It takes a lot longer to detect USB drives, why in the world would they be
> detected before hard-wired drives?

Depends, some hard-wired drives take much longer to find than USB ones.

That being said, it would be great if the original reporter could use
'git bisect' and let the linux-usb and linux-scsi mailing list know what
the offending patch is, and we can take it from there.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
