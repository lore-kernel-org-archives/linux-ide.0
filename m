From: Tejun Heo <tj@kernel.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 14:22:17 +0900
Message-ID: <4B14A809.8000304@kernel.org>
References: <1259561052.2076.73.camel@pasglop>	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>	 <1259635420.2076.180.camel@pasglop> <1259644647.2076.204.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60328 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbZLAFV7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:21:59 -0500
In-Reply-To: <1259644647.2076.204.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

Hello,

On 12/01/2009 02:17 PM, Benjamin Herrenschmidt wrote:
> So I tried with implementing the link_online and link_offline callbacks
> and it doesn't fly very high.
> 
> When I unplug the bay, it displays:
> 
> ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> ata3: EH complete

You didn't schedule any EH actions, right?

> and doesn't really "unplug" it (ie, trying to access the device then
> causes all sorts of errors to pile up in the log). Plugging it back then
> causes it to soft reset and restore the DMA timings and it works again.
> 
> But it's overall sub optimal. Comparatively, it worked better without
> the link callbacks though I would call it sub-optimal :-)
> 
> What would be the best way to tell libata to just remove the device and
> not bother poking the HW again on an unplug and do as it does today on a
> plug without the link callbacks ?

libata-acpi.c does that.  Setting ATA_DFLAG_DETACH device flag and
scheduling EH will do that.  Please take a look at
ata_acpi_detach_device() but you must be *sure* that your hot unplug
notification is completely reliable.

Thanks.

-- 
tejun
