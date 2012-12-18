From: Andrius Narbutas <andrius.narbutas@gmail.com>
Subject: Re: Crash with Z77 chipset
Date: Tue, 18 Dec 2012 10:51:15 +0200
Message-ID: <50D02E83.3090403@gmail.com>
References: <50CF5143.5020207@gmail.com> <50CFE5E3.9080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:49067 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab2LRI6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2012 03:58:11 -0500
Received: by mail-lb0-f181.google.com with SMTP id ge1so403594lbb.26
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 00:58:09 -0800 (PST)
In-Reply-To: <50CFE5E3.9080003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2012.12.18 05:41, Robert Hancock wrote:
> My first thought would be that a power problem is a possibility. These
> kinds of setups with multiple HDs in a RAID setup are known to cause
> these issues in some cases if the PSU isn't adequate.

I do not think PSU is a problem, because:
1) All hard disks combined draw less energy than loaded CPU, even at 
heavy load (from HDD datasheet: "Read/Write: 6.80 Watts; Idle	6.10 
Watts" - difference is 0.7W per HDD, so < 3W combined, CPU draws ~40W 
when loaded, compared to idle). Loading CPU/RAM to max does not crash 
system at all
2) I'm planning power supplies at 2x needed power (you know, all those 
"Chinese Watt" system is unreliable). Anyway, should be more than enough 
for whole system (and CPU is almost at idle when creating filesystem, so 
load on PSU is very low - should be < 70W - that's almost nothing on 
560W PSU, even counting "Chinese Watt" coefficient)
3) If PSU is fault - why it fails at exact the same place? Most of 
hardware failures have some "random" factor - you get segfaults at 
random places from faulty RAM, crashes from dying PSU when doing random 
tasks... But now it fails at exactly the same place (when using the same 
kernel)
4) Let's say PSU is faulty. Then how comes, that with 3.6.10 kernel i 
still have control over system (when it crashes) - so only disk 
subsystem fails? Because it has only one 12V rail - you cannot 
disconnect disks from system, without killing motherboard power too. But 
after crash i still can do `ssh root@deadhost 'echo b > 
/proc/sysrq-trigger'` - so system is alive and working well (just disks 
are dead)

I could imagine that motherboard itself is faulty (well, interesting 
anyway - why it fails only on heavy I/O load), so i will try to get 
Windows Server installed to check if that will work.

