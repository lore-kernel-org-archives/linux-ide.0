From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Wed, 21 Jun 2006 23:01:29 +0900
Message-ID: <44995139.30808@gmail.com>
References: <200606210942.33578.boac@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:10168 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932164AbWFUOBZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 10:01:25 -0400
Received: by wr-out-0506.google.com with SMTP id 36so183758wra
        for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 07:01:25 -0700 (PDT)
In-Reply-To: <200606210942.33578.boac@wanadoo.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Aalderd Bouwman wrote:
> Hello,
> 
> When I load module ahci when a drive is 'online' the drive is can be used 
> normal. When I disconnect the drive EH doesn't recognize that action. When I 
> reconnect the driver posts the following kernel-message:

I'm getting to dislike this via controller.  Again, the controller seems 
to lock up completely on hotplug events.  It might be that the current 
ahci's EH behavior just doesn't fit the via controller as the controller 
seems to lock up similarly in both NCQ and this case.  Maybe it doesn't 
like engine restart sequence (which, BTW, are all done in accordance to 
the AHCI spec).

> Here I disconnect both drives connected to the controller.
> After the second/third port-reset I also do rmmod ahci:
[--snip--]
> Jun 21 09:15:18 server BUG: unable to handle kernel NULL pointer dereference 
> at virtual address 00000010
> Jun 21 09:15:18 server printing eip:
> Jun 21 09:15:18 server e04926cc
> Jun 21 09:15:18 server *pde = 00000000
> Jun 21 09:15:18 server Oops: 0000 [#1]
> Jun 21 09:15:18 server last sysfs file: /block/sdb/sdb2/dev
> Jun 21 09:15:18 server Modules linked in: ahci libata cls_u32 sch_htb 
> xt_tcpudp iptable_filter iptable_nat ip_tables x_tables ip_nat_irc 
> ip_conntrack_irc ip_nat_ftp ip_nat ip_conntrack_ftp w83627ehf i2c_isa 
> i2c_core 3c59x
> Jun 21 09:15:18 server CPU:    0
> Jun 21 09:15:18 server EIP:    0060:[<e04926cc>]    Not tainted VLI
> Jun 21 09:15:18 server EFLAGS: 00010246   (2.6.17-rc5-mm2 #2) 
> Jun 21 09:15:18 server EIP is at ahci_tf_read+0xa/0x19 [ahci]
> Jun 21 09:15:18 server eax: 00000000   ebx: e049382f   ecx: de36c29c   edx: 
> 00000000
> Jun 21 09:15:18 server esi: de36c29c   edi: 00000000   ebp: e0488d00   esp: 
> de43ce84
> Jun 21 09:15:18 server ds: 007b   es: 007b   ss: 0068
> Jun 21 09:15:18 server Process scsi_eh_8 (pid: 15546, threadinfo=de43c000 
> task=c66ed550)
> Jun 21 09:15:18 server Stack: e0492455 de36c29c de43ce94 00000000 0000000a 
> de36c380 00000246 00000046 
> Jun 21 09:15:18 server fffffecc 0000001a de43cecc c0110a49 de43cefc de36c380 
> de36c29c de36c29c 
> Jun 21 09:15:18 server e04aa50e de36c29c de43cefc e04923f1 e04b0de3 de36c29c 
> e04923f1 de43cefc 
> Jun 21 09:15:18 server Call Trace:
> Jun 21 09:15:18 server <e0492455> ahci_softreset+0x64/0x1d1 [ahci]  <c0110a49> 
> __wake_up+0x14/0x1e
> Jun 21 09:15:18 server <e04aa50e> ata_do_reset+0x1b/0x4d [libata]  <e04923f1> 
> ahci_softreset+0x0/0x1d1 [ahci]
> Jun 21 09:15:18 server <e04b0de3> ata_eh_reset+0x78/0xff [libata]  <e04923f1> 

But, this is a driver bug.  I tried pretty hard to prevent this from 
happening.  Apparently, I screwed up.  If it's not too much trouble, can 
you please try libata-dev #upstream and see how it works with similar 
unloading scenario.  I'll try to reproduce it here but I wanna know for 
sure that the latest devel tree has the same issue.

Even if you're not familiar w/ git, accessing libata-dev #upstream is 
actually quite simple.

1. install git (on debian, just install git-core package)
2. $ git-clone git://git.kernel.org/pub/scm/linux/kernel/\
    git/jgarzik/libata-dev.git libata-dev
3. $ cd libata-dev
4. $ git-checkout -f upstream
5. copy over your .config and build.

-- 
tejun
