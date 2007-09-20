From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Thu, 20 Sep 2007 18:04:22 -0400
Message-ID: <46F2EE66.9060207@garzik.org>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070915170652.GA25504@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> Modern laptops with hotswap bays still tend to utilise a PATA interface 
> on a SATA bridge, generally with the host controller in some legacy 
> emulation mode rather than AHCI. This means that the existing hotplug 
> code in libata is unable to work. The ACPI specification states that 
> these devices can send notifications when hotswapped, which avoids the 
> need to obtain notification from the controller. This patch uses the 
> existing libata-acpi code and simply registers a notification in order 
> to trigger a rescan whenever the firmware signals an event.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> ---
> 
> Testing on an HP with the hotplug device as the slave on a PATA channel 
> flagged a bug - the notification needs to be tied to the channel handle 
> as well as the device ones. With this version, I can happily hotswap the 
> HP device. It ends up sitting for a few seconds while failing to 
> revalidate, but then recovers with everything working fine.

the code looks correct.  I have one main reservation.

how can we be sure that this is active only where other hand-programmed 
hotplug code is absent?

ACPI doesn't inherently know which of our controllers are already set up 
to do hotplug, so it seems like there is a possibility of conflict if 
both the firmware and the controller are chirping.

If we can quell my fears in that area, I'm ok with the change.

	Jeff



