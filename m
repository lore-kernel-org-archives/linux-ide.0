From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Sun, 1 Jun 2008 18:05:15 +0200
Message-ID: <20080601160515.GA4599@homac>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de> <20080529143541.GA24013@srcf.ucam.org> <483EBFC5.7020406@gmail.com> <20080529144934.GA24382@srcf.ucam.org> <20080529163201.GA4520@homac> <483EDC73.8030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <483EDC73.8030602@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Fri 30. May - 01:40:19, Tejun Heo wrote:
> Holger Macht wrote:
> > On Thu 29. May - 15:49:34, Matthew Garrett wrote:
> >> Got it. It works if I lose the ata_port_freeze() from 
> >> ata_acpi_detach_device. 
> > 
> > Tejun, any idea? This is in for quite some time now. Maybe there's some
> > involved...
> 
> Does changing it to ata_port_schedule_eh() make any difference?

Finally found a system to reproduce the freeze...

And yes, removing ata_port_freeze() and only doing ata_port_schedule_eh()
in the case where the device has already gone works and prevents the
freeze. Also the docking case works. If this change is not only for
finding out what's going wrong, I'm going resend the patch with your
documentation additions, ok?

Regards,
	Holger

