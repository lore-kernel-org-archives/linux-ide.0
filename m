From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Western Digital GreenPower drives and Linux
Date: Wed, 9 Apr 2008 21:18:35 +0100
Message-ID: <200804092118.35501.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:20529
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376AbYDIU2R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 16:28:17 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi all,

The subject may be a bit misleading since I haven't investigated the whole 
issue under other OS-es (nor do I plan to), but this is how the story goes..

Those fancy new WD GreenPower drives seem to be heavily suffering from the 
rapidly increasing head load/unload problem. And the bad thing is they don't 
respond to 'hdparm -B', which would mean (I think) their power management 
behaviour is solely up to their firmware.

I got one of them (WD5000AACS) recently and to my horror after less than three 
days of being power on this is what I saw:

9 Power_On_Hours       0x0032 100 100 000 Old_age Always  - 66
193 Load_Cycle_Count 0x0032 197 197 000 Old_age  Always  - 10233

At this rate the disk would reach it's design limit for load/unload cycles in 
around 80 days. Not good - so I implemented a lame workaround of keeping disk 
busy every couple of seconds - hopefully that won't kill it sooner that 
unloads would..

I am also currently talking with first line of WD's tech support trying to get 
some data on how exactly those drives manage head unloading, but that may not 
lead anywhere useful.

So in parallel I decided to ask here to see if someone knows something about 
this?

If it matters, I am running vanilla 2.6.24 on that box and sata_sil is driving 
that disk. Otherwise it is a pretty basic Ubuntu 7.10, a mix of ext3 and jfs 
filesystems, all mounted with noatime. More detailed information available on 
request.

Tvrtko




