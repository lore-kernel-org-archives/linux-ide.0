From: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Subject: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M bug
	: sata unusable with usbserial]
Date: Thu, 3 Mar 2011 15:58:12 +0100
Message-ID: <20110303145812.GA3489@frolo.macqel>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org> <20110228170556.GA29545@frolo.macqel> <20110228173634.GA23008@htj.dyndns.org> <20110228192700.GA3305@kroah.com> <20110301123452.GA1954@frolo.macqel> <20110301141627.GB12881@kroah.com> <20110301150018.GA17827@frolo.macqel> <4D6E477A.9020401@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D6E477A.9020401-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Summary :

When I started to listen to a USB serial GPS receiver, the interrupts
of my sata disk were blocked until reboot :(

Switching in the BIOS from 'APIC disabled' to 'APIC enabled' made the problem
disappear.

On Wed, Mar 02, 2011 at 08:34:50AM -0500, Mark Lord wrote:
> On 11-03-01 10:00 AM, Philippe De Muyter wrote:
> > On Tue, Mar 01, 2011 at 09:16:27AM -0500, Greg KH wrote:
> >> On Tue, Mar 01, 2011 at 01:34:52PM +0100, Philippe De Muyter wrote:
> >>> previously we had all but one usb interrupts on the same line as ata_piix :
> >>>   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
> >>> while now they are spread on different lines : 16, 18, 19, 21 and 22
> >>>
> >>> So I wonder if there is still a bug, but that it is not triggered anymore.
> >>>
> >>> Is there a way to tell which interrupt line the USB GPS receiver is connected
> >>> to ?
> >>
> >> See which USB bus the device is on, using lsusb.  It should match up
> >> with the usbX number in the above list.
> > 
> > Given that I get :
> > 
> >   tmp199:~ # lsusb
> >   ...
> >   Bus 007 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
> >   tmp199:~ # cat /proc/interrupts
> > 	     CPU0       CPU1
> >   ...
> >    19:     996143     995511   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb5, uhci_hcd:usb7
> >   tmp199:~ #
> > 
> > my USB GPS receiver and my sata disk still share the same interrupt, I assume ?
> > 
> > What's changed now is that this interrupt line is now IO-APIC-fasteoi instead
> > of XT-PIC-XT-PIC.  Maybe there's something to look at there ?
> > 
> >>
> >> Glad enabling APIC in your BIOS fixed this.
> > 
> > I am glad too :)
> 
> Nothing got "fixed" by doing that.
> Swept under the rug, yes.
> 
> But the bug is still there.

If it is a bug (what I also believe) it is not a new one :

Before installing 2.6.37-20-desktop (opensuse 11.4) on this new hardware,
I had the same problem with 2.6.31.14-0.6-desktop (opensuse 11.2) and
with 2.6.22.18-0.2-default (opensuse 10.3)

The only interesting file where I find the word 'XT-PIC' is
	arch/alpha/kernel/irq_i8259.c

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
