From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add MSI support to sata_vsc driver
Date: Thu, 17 Aug 2006 08:30:45 -0400
Message-ID: <44E46175.8040501@garzik.org>
References: <87840E8EE8A8D240A13F8AA92CAB07D9024C14A6@azsmsx402> <20060817040738.GA854817@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20650 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932336AbWHQMau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 08:30:50 -0400
In-Reply-To: <20060817040738.GA854817@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>, linux-ide@vger.kernel.org

Jeremy Higdon wrote:
> On Tue, Aug 15, 2006 at 05:25:14PM -0700, Wolstenholme, Daniel E wrote:
>>    In the course of some work I'm doing with MSI interrupts, I had an
>>    Intel GD81344 card I wanted to try out with MSI interrupts, and I
>>    found that it does indeed support MSI.  Here's a patch to add support.
> 
> You sent the patch as html.  That's not going to work.  Even the text/plain
> part of it is quoted/printable with lots of extra blank lines, etc.  If
> you're using Outlook, the only way to send a patch is to first turn off
> html and then send the patch as a text/plain attachment (as far as I know).
> 
>>    I implemented this rather simple patch using #ifdef CONFIG_PCI_MSI.  I
>>    noticed some other drivers, such as sata_mv and LSI's fusion drivers,
>>    use a kernel command-line parameter to enable MSI support.  I honestly
>>    don't know the advantage to this; it seems to me to be easier if it's
>>    enabled by default, as long as MSI support is selected in the kernel
>>    configuration.  If not, someone please let me know.
> 
> It might be that some platforms that have MSI enabled won't support it
> on certain machines where these chips are installed.  So it's probably
> best to make it an option.  I'll defer to jgarzik on this, however.

There's no need for #ifdefs at all.  You call pci_enable_msi() 
unconditionally, and if it fails, don't configure/use MSI.  From the 
driver's perspective, everything is handled with runtime function calls.

	Jeff



