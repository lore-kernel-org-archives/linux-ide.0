From: Eddie Atherton <stunnel@attglobal.net>
Subject: Re: ST340823A disk size issue - Revisited
Date: Wed, 29 Aug 2007 15:24:40 -0700
Message-ID: <46D5F228.1020907@attglobal.net>
References: <46C34C43.3020705@attglobal.net>
Reply-To: stunnel@attglobal.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kcout01.prserv.net ([12.154.55.31]:60246 "EHLO
	kcout01.prserv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbXH2WYV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 18:24:21 -0400
In-Reply-To: <46C34C43.3020705@attglobal.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Eddie Atherton wrote:
> Hi,
>
> I found the above thread while searching for the reason I was getting 
> lots of errors while trying to build out a new server.  Yes, I am 
> using an ST340823A drive.  However, I am getting slightly different 
> results for the drive capacity, which I'm not sure if that could cause 
> issues with the patch.
>
> I actually have 2 of these drives.  One is in a WinBlows machine, and 
> the other is in my new server.  Using an Ubuntu Live CD, I was able to 
> verify that the drive in the WinBlows machine is behaving exactly the 
> same as the original problem report.  However, the drive in my server, 
> running Slackware 11.0, reports a different "current capacity", as 
> shown here:
>
> Linux version 2.6.17.13 (root@tree) (gcc version 3.4.6) #1 Sat Sep 9 
> 01:11:49 CDT 2006
> ...
> hda: Host Protected Area detected.
>        current capacity is 78165359 sectors (40020 MB)
>        native  capacity is 78165361 sectors (40020 MB)
> hda: Host Protected Area disabled.
> hda: 78165361 sectors (40020 MB) w/512KiB Cache, CHS=65535/16/63, 
> UDMA(100)

An update to this.  I applied the latest patch set at the time, rc3 + 
git7, and it all appeared to work.  I didn't get the errors any more.

Well, I didn't the first time I checked.  :)

Now I've noticed that they are happening again.  Sometimes.  Here's the 
interesting part, this is what I saw one time:

Linux version 2.6.23-rc3-git7-smp (root@Brutus) (gcc version 3.4.6) #2 
SMP Wed Aug 29 04:12:27 PDT 2007
...
hda: Host Protected Area detected.
        current capacity is 78165357 sectors (40020 MB)
        native  capacity is 78165361 sectors (40020 MB)
hda: Host Protected Area disabled.
hda: 78165361 sectors (40020 MB) w/512KiB Cache, CHS=65535/16/63, UDMA(100)

Notice the current capacity.  It's low by 4 sectors, where previously it 
was only 2.  My guess is that my "working" versions were when the sector 
count was an even number, which is why I questioned the patch 
initially.  Looking back through my /var/log/syslog, I see capacities 
of, in chronological sequence:

78165359
78165360
78165360
78165359
78165359
78165357
78165357
78165358
78165357
78165359

Weird.

Cheers,
Eddie
