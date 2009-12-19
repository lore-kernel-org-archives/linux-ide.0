From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32 seemed to have broken nVidia MCP7A sata controller
Date: Sat, 19 Dec 2009 02:29:33 -0500
Message-ID: <4B2C80DD.9080005@garzik.org>
References: <7c8826910912182213o2e0e8af7ic305f150c52e0618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:63433 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbZLSH3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 02:29:36 -0500
In-Reply-To: <7c8826910912182213o2e0e8af7ic305f150c52e0618@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Cui <cuicui@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 12/19/2009 01:13 AM, Mike Cui wrote:
> I have an nVidia MCP7A AHCI controller. I upgraded to 2.6.32.2 and my
> system deterministically freezes trying to mount file systems. Once in
> a while it will come back and finish booting after freezing for 1
> minute or 2. dmesg indicates that there were NCQ errors, but 2.6.31
> anb before has always worked flawlessly for me. What changed in
> 2.6.32? I will be more than happy to help track down this issue.

> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata1.00: cmd 61/08:00:4f:ad:03/00:00:00:00:00/40 tag 0 ncq 4096 out
>           res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: hard resetting link
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1.00: device reported invalid CHS sector 0

Looks like things are timing out, and then go downhill from there.  This 
explanation of timeout gives some hints on possible causes: 
http://ata.wiki.kernel.org/index.php/Libata_error_messages#Error_classes

The ideal would be if you could bisect between 2.6.31 and 2.6.32, to see 
if it's a software change that is the cause.

Looking at drivers/ata/ahci.c history, the only thing that -might- cause 
problems is 388539f3ff0cf1de926b03f94e1eec112358f74d ('git show $commit' 
for full commit info and diff).

	Jeff


