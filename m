From: dwm@austin.ibm.com
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 10:00:41 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406141500.i5EF0f20024730@falcon10.austin.ibm.com>
References: <200406141636.01353.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:47452 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263191AbUFNPBA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 11:01:00 -0400
In-reply-to: <200406141636.01353.bzolnier@elka.pw.edu.pl> 
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com

  On certain platforms, it is desired that even devices soldered to the 
  MB be hotpluggable, at least in the logical sense.  

++doug


On Mon, 14 Jun 2004 16:36:01 +0200, Bartlomiej Zolnierkiewicz wrote:
>
>[ Greg added to cc: ]
>
>On Monday 14 of June 2004 11:58, Christoph Hellwig wrote:
>> On Sun, Jun 13, 2004 at 07:36:08PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> > > IMHO the PCI ->probe methods should always be __devinit.  It's rather
>> > > hard to make sure they're never every hotplugged in any way, especially
>> > > with the dynamic id adding via sysfs thing.
>> >
>> > I generally agree but IMO it makes no sense for i.e. piix.c.
>>
>> Are you sure?  I've seen piix3/4 in very strange place, iirc even in
>> a docking station which is hotpluggable.
>
>Do you mean that south-bridge chipset itself is hotpluggable?
>
>AFAIK it is only ATA hotplug not PCI one.
>
>> And even if for this special hardware it's usually not doable there
>> are things like greg's fake hotplug pci driver.  So a non-__devinit pci
>> probe method is a bug, please fix them in PCI.
>
>Greg, should I add "fake" PCI hotplug support to some IDE
>drivers just to make fake hotplug PCI driver happy?
>
>Cheers.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


