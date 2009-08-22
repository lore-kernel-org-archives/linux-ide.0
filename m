From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: waiting for the drives to settle
Date: Sat, 22 Aug 2009 12:13:39 -0400
Message-ID: <4A901933.6000709@garzik.org>
References: <54773205.20090820114051@web.de> <4A8D7203.50006@garzik.org> <969415927.20090821095633@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60765 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbZHVQNm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 12:13:42 -0400
In-Reply-To: <969415927.20090821095633@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

On 08/21/2009 03:56 AM, Andrei Martynov wrote:
> Thursday, August 20, 2009, 5:55:47 PM, Jeff Garzik wrote:
>
>> Have you verified this is needed, under libata?  We already have several
>> waits...
>
> Unfortunately it is needed. It is embedded system, where bootloader
> always tries to boot from the first device (dvd-rom). Second device
> (hard disk) is not yet ready when kernel is loaded from flash and does
> probe.

Can you show us the dmesg (printk) output from libata, _without_ 
dev_select or other "wait for drive to settle" special code?

Turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h before 
generating this output, please.

Thanks,

	Jeff




