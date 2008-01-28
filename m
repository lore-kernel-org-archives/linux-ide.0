From: Mark Lord <liml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 15:32:28 -0500
Message-ID: <479E3BDC.2080708@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <479E24F7.4090502@rtr.ca> <200801281404.12937.gene.heskett@gmail.com> <479E399C.1030409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2604 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbYA1Uc3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 15:32:29 -0500
In-Reply-To: <479E399C.1030409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Gene Heskett wrote:
>> ..
>> And so far no one has tried to comment on those 2 dmesg lines I've quoted a couple of times now, here's another:
>> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
>> [    0.000000] If you got timer trouble try acpi_use_timer_override
>> what the heck is that trying to tell me to do, in some sort of broken english?
> ..
> 
> I think it says this:
> 
>  "If your system is misbehaving, then try adding the acpi_use_timer_override
>   keyword to your kernel command line (/boot/grub/menu.lst) and see if it helps."
> 
> So, you can either hardcode it in /boot/grub/menu.lst (just add it to the end
> of the first line you see there that begins with the word "kernel".
> 
> Or you can just try it temporarily at boot time (safer, but tricker),
> by catching GRUB (the bootloader) before it actually loads Linux.
> 
> Usually there's some key or something it says you have 3 seconds to hit for a "menu",
> so do that, and then use the cursor keys to find the first "kernel" line in that menu
> and hit "e" (edit) to go and add the acpi_use_timer_override keyword to the end of
> that line (same as above).
..

Minor correction (having just tried it here):  once you see the GRUB (boot) menu,
hit the letter e to edit the first entry, then scroll to the "kernel" line,
and hit the letter e again to edit that line.  It should put you at the end of the
line, where you can just type a space and then acpi_use_timer_override and then
hit enter to finish the (temporary) edit.  Then hit b for boot.

-ml
