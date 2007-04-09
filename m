From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 9 Apr 2007 23:33:55 +0200 (MEST)
Message-ID: <200704092133.l39LXtrM022972@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:58986 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbXDIVeE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Apr 2007 17:34:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: phil@ipom.com
Cc: linux-ide@vger.kernel.org

On Mon, 9 Apr 2007 13:26:54 -0700, Phil Dibowitz wrote:
>On Mon, Apr 09, 2007 at 12:18:09PM +0200, Mikael Pettersson wrote:
>> I've seen reports of issues like these with second-generation
>> Promise SATA chips and SATAII (3Gbps) drives, but this is the
>> first time I've seen any issues with a first-generation chip.
>>
>> 1. Please try 2.6.21-rc6 plus the following two patches:
>>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21-rc6
>>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21-rc6
>>
>>    This probably won't eliminate the errors, but should improve
>>    the level of detail in the error messages.
>
>It doesn't appear to have changed much. After a reboot, I have:
>
>ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2 frozen
>ata1.00: (port_status 0x20200000)
>ata1.00: cmd c8/00:90:f2:fb:a6/00:00:00:00:00/e0 tag 0 cdb 0x0 data 73728 in
>         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x14 (ATA bus error)
...
>Any other info I can provide?

The error decodes as:
port_status 0x20200000: Drive Error during Packet Command Cycle
(the drive signalled an error to the controller)

SErr 0x380100: CRC error, Disparity error, 10B-to-8B decoding error,
non-recoverable transient data integrity error.

My conclusion is that the link between the controller and the drive
is corrupting messages. This is almost certainly a hardware problem,
and could be a broken motherboard (you wrote that you hadn't used
the mobo's Promise chip before), bad cables, bad drives, a bad power
supply, or electrical interference.

/Mikael
