From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 88SE9172 additional PCI ID: 1b4b:9172
Date: Wed, 29 May 2013 22:41:22 -0600
Message-ID: <51A6D872.2090100@gmail.com>
References: <20130528002234.GB18531@mtj.dyndns.org> <20130528071220.3601.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50769 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3E3El0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 00:41:26 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so26208746iec.7
        for <linux-ide@vger.kernel.org>; Wed, 29 May 2013 21:41:25 -0700 (PDT)
In-Reply-To: <20130528071220.3601.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 05/28/2013 01:12 AM, George Spelvin wrote:
>> I don't think it's a typo.
>
> Indeed, pci.ids has three entries.
>
>> And we'll need a separate entry
>>
>>> (If I enable VT-d and the IOMMU, the devices are recognized but not the
>>> disks plugged into them, but I'm still working on figuring that out.)
>>
>> when the device gets working.
>
> I don't quite understand this.  With VT-d disabled in the BIOS,
> the devices *are* working.  I even have a port multiplier plugged
> into one.  (Which gets all confused by hdparm -m16, but whatever.)
>
> When I get time, I'm going to play with various BIOS and kernel
> options to narrow down the problem.  But that's for later.
>
> Can you explain what you think is not working now?

There are some known problems with some Marvell controllers and VT-d, 
apparently they issue PCIe requests containing the wrong device function 
causing IOMMU faults to occur. I believe a PCI quirk to work around the 
problem was either being worked on or finished - if it's in already, it 
might need this device ID added to it as well.
