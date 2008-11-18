From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Assistance with error
Date: Tue, 18 Nov 2008 04:43:01 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0811180441170.29263@p34.internal.lan>
References: <C907368E-3242-4D88-B879-AF621A17A93A@infogears.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:43200 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbYKRJnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 04:43:04 -0500
In-Reply-To: <C907368E-3242-4D88-B879-AF621A17A93A@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org



On Tue, 18 Nov 2008, Rusty Conover wrote:

> Hello Linux IDE Guys,
>
> I'm encountering this error after a few days of decent load on the disks:
>
> Its always on the same device sdd, I've swapped out the physical disks and 
> the error persists.  Do you have any ideas what the cause could be?  I've 
> checked connections, could it be a bad SATA cable?
>
> The full dmesg output is available at:
>
> http://www.infogears.com/disk-failure.log
>
> Kernel is:
>
> Linux version 2.6.26.6-79.fc9.i686.PAE (mockbuild@) (gcc version 4.3.0 
> 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Fri Oct 17 1
> 4:38:28 EDT 2008
>
> The FAQ mentions power issues being a possibility but I'm not sure if there 
> is a way to tell if that is the cause since it it always the same device in a 
> 6 device array.
>
> Any insight would be most appreciated.

Try disabling NCQ on the drives, I get the same/similar NCQ errors if I have
it enabled, on some drives, it just does not work.

# Define DISKS.
cd /sys/block
DISKS=$(/bin/ls -1d sd[a-z])

# Disable NCQ on all disks.
echo "Disabling NCQ on all disks..."
for i in $DISKS
do
   echo "Disabling NCQ on $i"
   echo 1 > /sys/block/"$i"/device/queue_depth
done

Then, see if the same problem repeats itself, or if it occurs less often..

Justin.

