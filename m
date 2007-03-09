From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]: libata-core: Add support for ATA_HORKAGE_DIAGNOSTIC
Date: Fri, 09 Mar 2007 08:05:24 -0500
Message-ID: <45F15B94.7050208@garzik.org>
References: <20070308231804.110f76a0@lxorguk.ukuu.org.uk>	<45F15781.7090402@garzik.org> <20070309140318.174a95b3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55944 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767262AbXCINF0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 08:05:26 -0500
In-Reply-To: <20070309140318.174a95b3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> -                if (print_info) {
>>> +                if (print_info && !(ata_device_blacklisted(dev) & ATA_HORKAGE_DIAGNOSTIC)) {
>>>  			ata_dev_printk(dev, KERN_WARNING,
>>>  "Drive reports diagnostics failure. This may indicate a drive\n");
>>>  			ata_dev_printk(dev, KERN_WARNING,
>> I don't understand this one at all.
>>
>> The original point of the message was to poke people so that they poke 
>> their vendors into fixing the firmware, which is indeed non-spec.  I 
>> would rather not silence a "your device is operating out-of-spec" warning.
> 
> The moment it goes near a business oriented distribution this becomes a
> problem because the flack all lands on either the system vendor or the OS
> product vendor both of whom will simply delete the check. At least this
> way it stays in for cases that actually matter.

Maybe, but it's also possible the vendor and user will know that their 
device is operating out-of-spec.

libata will default to the more-information setting, and distros are 
free to change it if they wish.

	Jeff



