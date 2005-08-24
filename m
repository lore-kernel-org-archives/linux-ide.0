From: Wes Newell <w.newell@verizon.net>
Subject: Re: Sis180 Jetway S755Max
Date: Wed, 24 Aug 2005 01:20:55 -0500
Message-ID: <430C11C7.8010308@verizon.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>	<4309A268.8090203@gmx.net>
 <430AA69A.1030307@verizon.net>	<430AD885.4080001@gmx.net>
 <430B63D1.6080108@verizon.net> <m3fyt02y2t.fsf@anduin.mandrakesoft.com>
 <430B91C1.6040407@verizon.net> <430B9D0A.3060202@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms040pub.verizon.net ([206.46.252.40]:27901 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751475AbVHXGTZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Aug 2005 02:19:25 -0400
Received: from [192.168.0.2] ([71.244.20.31])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0ILP004WGQWCJE93@vms040.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 24 Aug 2005 01:19:24 -0500 (CDT)
In-reply-to: <430B9D0A.3060202@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Arnaud Patard <apatard@mandriva.com>, "linux.ide" <linux-ide@vger.kernel.org>

Uwe Koziolek wrote:

>Hello Wes,
>
>i include for you a hothack for SiS180 into the sata5513, untested and
>not pretty.
>
>  
>
I tried this one first. It found the controller but errored out. here 
the relevant dmesg.

Linux version 2.6.11-12mdkcustom (root@wes2.com) (gcc version 3.4.3 
(Mandrakelinux 10.2 3.4.3-7mdk)) #1 Tue Aug 23 23:58:08 CDT 2005

SIS5513: IDE controller at PCI slot 0000:00:0c.0
SIS5513: chipset revision 0
SIS5513: IDE controller at PCI slot 0000:00:0c.0
SIS5513: chipset revision 0
SIS_IDE: probe of 0000:00:0c.0 failed with error -1


>additional i include the patch submitted by Arnaud Patard.
>
>  
>
I'm not sure how or to which sata_sis.c file to apply this. I've got the 
one that came with the above kernel, and then I've got the one I 
downloaded from SIS that locks up the system when a pata drive is 
installed on the sis180. The first was simple enough, just replaced the 
original sis5513.c and recompiled the kernel. Don't know what to do with 
this one.

>If the last one works, it is the better solution, with chances to be
>included into the kernel.
>
>  
>
Is the sata_sis patch suppossed to add pata support. Can't tell from his 
message and the code is greek to me.
