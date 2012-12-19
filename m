From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Crash with Z77 chipset
Date: Tue, 18 Dec 2012 21:36:51 -0600
Message-ID: <50D13653.3000708@gmail.com>
References: <50CF5143.5020207@gmail.com> <50CFE5E3.9080003@gmail.com> <50D02E83.3090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61155 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab2LSDmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2012 22:42:08 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so2050186iea.22
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 19:42:07 -0800 (PST)
In-Reply-To: <50D02E83.3090403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrius Narbutas <andrius.narbutas@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/18/2012 02:51 AM, Andrius Narbutas wrote:
> On 2012.12.18 05:41, Robert Hancock wrote:
>> My first thought would be that a power problem is a possibility. These
>> kinds of setups with multiple HDs in a RAID setup are known to cause
>> these issues in some cases if the PSU isn't adequate.
>
> I do not think PSU is a problem, because:
> 1) All hard disks combined draw less energy than loaded CPU, even at
> heavy load (from HDD datasheet: "Read/Write: 6.80 Watts; Idle    6.10
> Watts" - difference is 0.7W per HDD, so < 3W combined, CPU draws ~40W
> when loaded, compared to idle). Loading CPU/RAM to max does not crash
> system at all

The CPU has a voltage regulator in front of it which can compensate for 
dips in the input voltage. The disks don't. The wattage figures don't 
necessarily account for short-duration power draw peaks. And depending 
on how the drives are hooked up, especially if they are all on one 
cable, they can potentially see a problematic voltage drop.

> 2) I'm planning power supplies at 2x needed power (you know, all those
> "Chinese Watt" system is unreliable). Anyway, should be more than enough
> for whole system (and CPU is almost at idle when creating filesystem, so
> load on PSU is very low - should be < 70W - that's almost nothing on
> 560W PSU, even counting "Chinese Watt" coefficient)
> 3) If PSU is fault - why it fails at exact the same place? Most of
> hardware failures have some "random" factor - you get segfaults at
> random places from faulty RAM, crashes from dying PSU when doing random
> tasks... But now it fails at exactly the same place (when using the same
> kernel)
> 4) Let's say PSU is faulty. Then how comes, that with 3.6.10 kernel i
> still have control over system (when it crashes) - so only disk
> subsystem fails? Because it has only one 12V rail - you cannot
> disconnect disks from system, without killing motherboard power too. But
> after crash i still can do `ssh root@deadhost 'echo b >
> /proc/sysrq-trigger'` - so system is alive and working well (just disks
> are dead)
>
> I could imagine that motherboard itself is faulty (well, interesting
> anyway - why it fails only on heavy I/O load), so i will try to get
> Windows Server installed to check if that will work.


