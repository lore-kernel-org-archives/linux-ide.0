From: Tejun Heo <htejun@gmail.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Date: Tue, 23 Oct 2007 18:55:55 +0900
Message-ID: <471DC52B.20802@gmail.com>
References: <56020.194.255.108.253.1192004925.squirrel@root.dusted.dk> <20071012174153.69556b32.akpm@linux-foundation.org> <47105C53.7040603@lix-world.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:35944 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbXJWJ4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 05:56:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1436826rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 02:56:02 -0700 (PDT)
In-Reply-To: <47105C53.7040603@lix-world.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steen Eugen Poulsen <sep@lix-world.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, lists@dusted.dk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Steen Eugen Poulsen wrote:
> Sep 28 04:32:40 locker ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
> action 0x2 frozen
> Sep 28 04:32:40 locker ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00
> tag 0 cdb 0x0 data 123392 in
> Sep 28 04:32:40 locker res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask
> 0x202 (HSM violation)
[--snip--]
> Another machine:
> 
> Sep 28 03:47:55 dragonslair ata1.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> Sep 28 03:47:55 dragonslair ata1.00: cmd
> b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 in
> 
> Sep 28 03:47:55 dragonslair res 50/00:f8:00:4f:c2/00:00:00:00:00/00
> Emask 0x202 (HSM violation)
[--snip--]
> Sep 28 04:33:52 liferaft kernel: ata1.00: exception Emask 0x0 SAct 0x0
> SErr 0x0 action 0x2 frozen
> Sep 28 04:33:55 liferaft kernel: ata1.00: cmd
> b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 in
> Sep 28 04:33:55 liferaft kernel:          res
> 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
> Sep 28 04:33:55 liferaft kernel: ata1: soft resetting port
> Sep 28 04:33:55 liferaft kernel: ata1: SATA link up 3.0 Gbps (SStatus
> 123 SControl 300)
> Sep 28 04:33:55 liferaft kernel: ata1.00: configured for UDMA/133
> Sep 28 04:33:55 liferaft kernel: ata1: EH complete

All these are caused by smartd.  Updating should fix the problem.

> Note 2: The hardware didn't freeze for me and I believe the freeze is do
> to swap breaking due to the errors.

Above HSM violations should be harmless other than those messages.
libata resets the devices and should just go on.

> Note 3: dragonslair's harddisk actually crashed, kernel didn't die, it
> just remounted read only. Reboot and the disk was missing, more reboot
> and the machine started with all disks running again, been stable since
> the 28th Sep. (knock on wood)

libata EH can't really recover from actual hardware failures but some
drives come back on if you hot unplug and then replug it.

-- 
tejun
