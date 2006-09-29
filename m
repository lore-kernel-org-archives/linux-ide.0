From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA status reports update
Date: Fri, 29 Sep 2006 05:53:39 -0400
Message-ID: <451CED23.1090909@garzik.org>
References: <451CE8EC.1020203@garzik.org> <200609291149.37009.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51361 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751096AbWI2Jxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Sep 2006 05:53:42 -0400
In-Reply-To: <200609291149.37009.prakash@punnoor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Prakash Punnoor wrote:
> Am Freitag 29 September 2006 11:35 schrieb Jeff Garzik:
>> I updated the info at http://linux-ata.org/ to match the current code in
>> linux-2.6.git.
>>
>> Hardware and driver status:
>> 	http://linux-ata.org/driver-status.html
>>    notably, the driver matrix:
>> 	http://linux-ata.org/driver-status.html#matrix
> 
> Does any ETA exists for NV NON-AHCI NCQ support? The proabably not so small 
> userbase would be happy if work on it would be done...

No ETA at all.  It is admittedly low priority, and unfortunately the 
only people with hardware documentation are myself and NVIDIA.

There is a non-working patch, if someone wants to debug it, though:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.17-nv-adma.patch.bz2

	Jeff



