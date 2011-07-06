From: Tim Small <tim@buttersideup.com>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Wed, 06 Jul 2011 21:34:53 +0100
Message-ID: <4E14C6ED.5040208@buttersideup.com>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk> <20110610102403.GE15235@htj.dyndns.org> <4DF249BB.3040808@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:34224 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab1GFVfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 17:35:51 -0400
In-Reply-To: <4DF249BB.3040808@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hubert Bailey <hbailey@marvell.com>, lil@marvell.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 10/06/11 17:43, Tim Small wrote:
>
> I've ordered an 88SE9128 card (Hightpoint RocketRaid 620) as well, so
> I'll be able to compare the two, as well as a sata_mv 88SX7042 as well.
>   

OK, so in fact it seems that I'd ordered a RocketRaid 620WDA - which has
an 88SE9125 on it, not a 88SE9128 (as the 620 has).

If I remember correctly (it was a couple of weeks ago now - just before
I went on holiday) the 620WDA did actually work with the SiI 3726 PMP in
FSC mode, when I was using the original HighPoint firmware which it
shipped with, but it doesn't when I use the Marvell Firmware (I didn't
want to try the Marvell firmware on the 620WDA, but the Marvell firmware
update utility I had "upgraded" it - and now I can't put the Highpoint
firmware back on it - partly because I don't have a copy of it anywhere).

I was actually trying to upgrade the 88SE9123 firmware at the time -
that turned out to be quite a lot more difficult than I was expecting:

http://buttersideup.com/files/flashrom/lycom-pe115-flashrom-buspirate-2.jpg

http://buttersideup.com/files/flashrom/at26f004-support.patch

Marvell guys - can you tell whoever writes your DOS "mvf.exe" firmware
updater for the 88SExxxx cards, that the update process fails to
unprotect sectors on Atmel AT26F004 SPI flash chips - it also fails to
check for protected sectors prior to attempting programming - so that
you end up with part of one firmware version together with parts (which
were in protected sectors) of whatever was there before.  Also -
actually automatically backing up the previous firmware would be nice,
as well as some instructions for going back to the previous version in a
README file (PLEASE PLEASE PLEASE), instead of leaving the users to
scour the Internet for solutions to restoring non-working cards:

http://www.station-drivers.com/forum/viewtopic.php?p=11162#p11163

... oh, and whilst I think about it, when upgrading the flash on a
machine with multiple adaptors - if the updater fails to successfully
update one adaptor, maybe it should then STOP, rather than steaming on
and breaking the rest of the cards in the same machine one after the other?


Anyway, after all that I didn't actually get working PMP support with
either card - at least not with that particular firmware image (which
contains the version string: 1.0.0.1028 and is in "U3S6R0.zip" from
http://www.station-drivers.com/page/marvell.htm ) the 88SE9125 seems to
read successfully, but gives extremely slow read speeds - around 1
megabyte per second for simultaneous drive accesses in FBS mode, whereas
the 88SE9123 gives the same behaviour as it did with the original
firmware i.e. timeouts + resets during simultaneous reads in FBS mode.



Is there a different firmware version which I should be trying with this
card?  Any chance of an actual changelog for the different firmware
versions?

Anyone have a 620WDA and wouldn't mind backing up the firmware from it
for me?

Is there a datasheet for the 88SE91xx chips around that I can get hold
of - NDA or otherwise?

Thanks,

Tim.
