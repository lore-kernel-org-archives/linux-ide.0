From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Fri, 21 Sep 2007 11:35:05 +0900
Message-ID: <46F32DD9.7010509@gmail.com>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070920222138.GA3740@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Sep 20, 2007 at 06:04:22PM -0400, Jeff Garzik wrote:
> 
>> the code looks correct.  I have one main reservation.
>>
>> how can we be sure that this is active only where other hand-programmed 
>> hotplug code is absent?
> 
> Yes, that's difficult. As Tejun pointed out, there's missing locking 
> here at the moment - if I add that, am I right in thinking that the 
> worst case scenario is that the hotplugging path will be called twice?

Yeah, should be and libata EH won't have too much problem handling
duplicate events.

> One option would be to limit this to PATA-style controllers - I'm not 
> aware of any mobile hardware shipping with natively hotplug-capable 
> controllers, so that would probably do for the moment. If (when) they 
> move to AHCI, with luck the native hotplugging will work and we won't 
> have to worry about this so much.
> 
> The alternative would be to add a flag to the ap structure indicating 
> whether the hotplugging is handled by the firmware or not. If we find a 
> reference to a controller or port in the firmware tables, it probably 
> indicates that the hardware has opinions about how this should be 
> handled. We might be safer leaving it to the firmware in those cases, 
> and using that flag to skip the controller-specific hotplug code.

I was thinking the other way around.  I'd rather depend on hardware
provided events than firmware provided ones.  How about flagging drivers
which can do native hoplugging and using ACPI hotplugging only if the
driver can't do it natively?

Thanks.

-- 
tejun
