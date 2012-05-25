From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ATA errors corrupt other I/O & set / readonly
Date: Thu, 24 May 2012 19:03:56 -0600
Message-ID: <4FBEDA7C.8030007@gmail.com>
References: <4FA0F76E.3050509@earthlink.net> <4FB82C9A.9020508@gmail.com> <4FB87985.1080501@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33862 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab2EYBEB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2012 21:04:01 -0400
Received: by gglu4 with SMTP id u4so483575ggl.19
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2012 18:04:00 -0700 (PDT)
In-Reply-To: <4FB87985.1080501@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@earthlink.net>
Cc: linux-ide@vger.kernel.org

Sorry I missed your response initially. Please use reply-to-all.

On 05/19/2012 10:56 PM, Felix Miata wrote:
> On 2012/05/19 17:28 (GMT-0600) Robert Hancock composed:
>
>> On 2012/05/02 Felix Miata wrote:
>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=43128
> ...
>>> Please, what should I do?
>
>> It's hard to follow the discussion in the openSUSE bug report. I'm not
>> sure if there was any dmesg posted from the case where other IO was
>> being interfered with by the problems with the external device. In AHCI
>> mode that really shouldn't happen, but in IDE mode on Intel controllers
>> it may be more possible because of the PATA emulation that's effectively
>> being done by the controller.
>
> The "other" I/O being done while I'm attempting to use these is usually
> limited to tty I/O, either bash or MC running in bash running on
> tty[1-6] in runlevel 3 to copy files between one HD and another, usually
> both source and target in individual RX-358 units, often just from the
> NTFS partition to the EXT2 partition in the same RX-358 unit. The STB[1]
> that I bought the V2 to use with only writes to Windows partitions via
> USB connection, which complicates life by forcing me to move files off
> the NTFS partition to free up space.
>
> The V2 also produces trouble in USB mode, and when connected via SATA to
> WinXP, for which the only workaround I know is rebooting until it gets
> recognized. Connected via USB to the STB the NTFS partition would
> sometimes become marked so as to become unavailable to the STB. The only
> way to reenable access to it is to have WinXP run CHKDSK on it, which is
> how I would discover the unreliability of its connectibility to WinXP.
>
> I use these devices with multiple machines, many of which are Dells
> whose BIOS contain the string "AHCI" nowhere in setup. I never set any
> machine to use a legacy mode except temporarily for troubleshooting
> purposes, but this doesn't necessarily mean AHCI is used.
>
> IIRC, I was only ever asked for /var/log/messages, never dmesg. I can
> never remember what distinguishes the content provided by the two.

/var/log/messages contains non-kernel logging as well, but it sometimes 
doesn't show all log messages output in dmesg.

>
> If you want a dmesg attached to either bug, I need to know when and how
> you want me to try and get it. I say "try" because once corruption
> begins, getting dmesg is unlikely via keyboard on a tty, and potential
> methods of fetching it any other way are not known to me. It might be
> sitting on tty11 or elsewhere that I could copy manually from if I knew
> well enough what to copy or omit.

It's possible you may be able to use a previously-opened SSH login from 
another machine to see dmesg output even if the process running on the 
console is stalled due to an I/O problem. Also, you could try booting 
from a USB live image so that any ATA issues won't prevent the system 
from reading executables.

>
>> It's not possible to put in a blacklist entry for a specific SATA
>> enclosure because they're essentially a passive device and there's no
>> way to identify them through software (unless they have a custom ID
>> string like the WD MyBook drives). If it only works properly at 1.5 Gbps
>> then a module/boot parameter may be the best solution.
>
> It would be helpful if I knew a blanket cmdline parameter to use to cap
> everything at 1.5 instead of for each machine having to discover all the
> bus particulars and remember which go where on reboot to place them into
> effect only for the port the V2 is or might be connected to. I can't
> picture myself noticing on any of my machines whether I/O was capped at
> 1.5 or not. The maximum number of HDs used at once in any of them would
> be two in most, and three in two machines with RAID1 configured.

I haven't tested but AFAICS, using libata.force=1.5Gbps should force 1.5 
Gbps on all ports.

>
> A couple of weeks after filing the kernel.org bug I contacted the
> manufacturer again to provide the new information contained in the bugs.
> Again it offered to replace. Only yesterday I finally answered the offer
> that I'd probably prefer to keep it in lieu of wasting more money on
> shipping only to be left with no opportunity for further testing and bug
> follow-up, and yet another replacement no better than the original, or a
> store credit making me shop for something else with equivalent
> functionality.
>
> If there was a kernel dev interested in pursuing this it might be
> possible to get the manufacturer to provide a V2 device to test with.
> Considering the current delivered price of the V2 is roughly half that
> of the V1 it appears remaining stock is trying to be dumped.
>
> [1] http://www.manhattan-digital.net/rs1933.htm

