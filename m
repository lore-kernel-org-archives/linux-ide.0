From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fixups to ATA ACPI hotplug
Date: Tue, 20 May 2008 11:20:38 +0100
Message-ID: <20080520102038.GA2441@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506092653.GB4378@homac> <20080506093628.GA12469@srcf.ucam.org> <20080519162934.GA15623@srcf.ucam.org> <20080520074442.GA14417@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080520074442.GA14417@homac>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 20, 2008 at 09:44:42AM +0200, Holger Macht wrote:

> * In case of an ACPI_NOTIFY_DEVICE/BUS_CHECK, evaluate _STA to check if
>   the device has been plugged or unplugged. If plugged, hotplug it, if
>   unplugged, just signal event to userspace
>   (initial patch by Matthew Garrett <mjg59@srcf.ucam.org>)

The only issue I can see is that this one doesn't check _EJ0. Unless 
that's done, you'll (on some hardware) evaluate _STA on the bay itself 
rather than the device within the bay, which leads to confusion as to 
whether the device has been inserted. Other than that, looks good. 
Jeff's sent my patch to Linus, so can you redo this on top and I'll sign 
it off?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
