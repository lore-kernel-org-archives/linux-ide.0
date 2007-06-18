From: Mark Lord <liml@rtr.ca>
Subject: Re: [PROBLEM]: hdparm strange behaviour for 2.6.21 and later
Date: Mon, 18 Jun 2007 16:01:02 -0400
Message-ID: <4676E47E.5050209@rtr.ca>
References: <200706161958.05313.djart@linux.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2976 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760462AbXFRUBE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2007 16:01:04 -0400
In-Reply-To: <200706161958.05313.djart@linux.gr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thanos Kyritsis <djart@linux.gr>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanos Kyritsis wrote:
> Hello,
> 
> starting with kernel 2.6.21 and up to kernel 2.6.22-rc4, I'm having the 
> following problem:
> 
> /etc/rc.d/rc.local contains the following:
> /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hda
> /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdb
> /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdc
> /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdd
> 
> (I'm using Slackware, no Debian-style automated hdparm.conf is running 
> during bootup, that's why these are in rc.local)
> 
> The above seem to somehow lock up the boot procedure just at the point 
> where rc.local gets executed, so the system never reaches login prompt.
> All drivers (kernelspace) and system daemons (userspace) before rc.local 
> do normally load, but there are no strange messages in the console or in 
> the system logs and because I cannot login, I cannot trace it any further. 
> I believe the kernel is in running state because the machine responds to 
> ICMP pings from the ethernet, but since the login prompt is not up, the 
> already running sshd/telnetd do not provide any help.
> 
> The strange thing is that if I remove all the quiet options (-q) from the 
> above commands, everything works like it should. Furthermore, if I 
> comment them out from rc.local, then boot, login, and execute them by 
> hand (with -q), again everything works like it should. Lockup only happens if 
> I run 2 or more hdparm commands, if I leave only one (doesn't matter 
> which one) hdparm command in rc.local (with -q), it works.

Sounds like a (kernel) timing issue.
The "-q" option gets rid of some intermediary printf's,
and nothing else.  So with -q, the ioctl() calls happen
much closer together in time.  Without -q, the intermediary
printf's likely cause a resched, giving the kernel more time
to complete anything left over from the earlier call.

????

Any difference with a modern version of hdparm?

-ml
