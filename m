From: Russell Whitaker <russ@ashlandhome.net>
Subject: Re: 2.6.35.9 bug shown in dmesg (fwd)
Date: Thu, 6 Jan 2011 11:09:21 -0800 (PST)
Message-ID: <alpine.LNX.2.00.1101061034080.1611@bigred.russwhit.org>
References: <alpine.LNX.2.00.1012301233380.3394@bigred.russwhit.org> <20110103230028.GA1456@localhost.localdomain> <alpine.LNX.2.00.1101052112010.1625@bigred.russwhit.org> <20110106161918.GA3008@r2bh72.net.upc.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:60325 "EHLO
	bigred.russwhit.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815Ab1AFTP2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 14:15:28 -0500
In-Reply-To: <20110106161918.GA3008@r2bh72.net.upc.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org



On Thu, 6 Jan 2011, Stanislaw Gruszka wrote:

> On Wed, Jan 05, 2011 at 10:21:21PM -0800, Russell Whitaker wrote:
>>> For some unknown reason resources needed by amd76xrom driver can not be
>>> available. Instead of return error, driver crash the kernel with
>>> messages like below. Patch fix that.
>>>
>>> amd76xrom" amd76xrom_init_one(): Unable to register resource 0x00000000ffc00000-0x00000000ffffffff - kernel bug?
>>
>> Sorry, in my case that's the wrong bug. First found the bug using
>> Slackware-current. So I stripped down his config file by removing
>> most of what I can't use, recompiled, and the bug was still there.
>>
>> I'm not using amd76xrom so went into a MTD submenu and changed it to
>> not set, etc, and found the bug is still there.
>
> I do not see any other problems except that one:
>
> 	BUG: unable to handle kernel paging request at f862aaa0
> 	IP: [<f8120282>] simple_map_write+0x82/0xbb [map_funcs]
>
> in dmesg's you provided in the first email. That BUG is from amd75xrom
> driver. Does dmesg without MTD compiled show something different?

The " - kernel bug?" line is gone.

> And this is also not clear for me from your first email, crash happened
> every time with pata or randomly?

There are two bugs. In order to reduce the problem to only one bug I
complied 2.6.35.10-smp without MTD's 4 drivers where the name starts
with "bios" and also compiled with pata.

Result, first four attempts at booting: oops 3, success 1.

To verify the problem is in pata I then replaced the pata code with the
ATA (depreciated) code, with no other changes, and recompiled.

Result, all attempts at booting: success every time.

(note: changing the kernel also means changing /etc/fstab to match)

   Russ
>
> Stanislaw
>
