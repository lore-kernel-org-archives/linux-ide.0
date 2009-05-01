From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
   question)
Date: Thu, 30 Apr 2009 19:51:28 -0600
Message-ID: <49FA55A0.8080303@gmail.com>
References: <E1LzLgA-0004j6-9W@closure.thunk.org> <49F90CA2.4080602@garzik.org> <20090430083309.437f9248@lithium.local.net> <20090430113445.GA4809@mit.edu> <20090430113814.GB4809@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:31252 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbZEABve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2009 21:51:34 -0400
In-Reply-To: <20090430113814.GB4809@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>, Alex Buell <alex.buell@munted.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>, Linux

Theodore Tso wrote:
> On Thu, Apr 30, 2009 at 07:34:45AM -0400, Theodore Tso wrote:
>> On Thu, Apr 30, 2009 at 08:33:09AM +0100, Alex Buell wrote:
>>> On Wed, 29 Apr 2009 22:27:46 -0400, I waved a wand and this message
>>> magically appears in front of Jeff Garzik:
>>>
>>>> As Tejun noted, try switching to AHCI mode in BIOS.
>>> But is there a way to switch modes without needing to go through the
>>> BIOS? Some laptops won't let you do that through BIOS. 
>> The BIOS setting already is in AHCI mode, and not in "compatibility
>> mode".  
> 
> Thinking about this a bit more, I'll bet the problem is the BIOS
> setting is only affecting the primary SATA ports (which are being
> grabed by ahci) and not the SATA port in the Ultrabay slot (which is
> being picked up by either the ata_piix or piix driver).  Sigh...

dmesg and lspci -vv output might be useful..
