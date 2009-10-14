From: Jim Paris <jim@jtan.com>
Subject: Re: disappearing block devices using EFI Partitioning
Date: Wed, 14 Oct 2009 11:10:55 -0400
Message-ID: <20091014151055.GA28792@psychosis.jim.sh>
References: <20091014112418.GJ25852@moomers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b.jim.sh ([75.150.123.26]:50199 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753341AbZJNPUJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 11:20:09 -0400
Content-Disposition: inline
In-Reply-To: <20091014112418.GJ25852@moomers.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Serebryany <igor47@moomers.org>
Cc: linux-ide@vger.kernel.org

Igor Serebryany wrote:
> Hi, 
> 
> 	I'm not sure if this is the right place to send this, but I'm
> 	not sure where else to send it...
> 
> 	I've been having a problem where sometimes, creating a new partition
> 	(parted mkpart) using GPT disk label causes the block device for the
> 	previously created partition to disappear.
> 
> 	Here is an example: http://pastebin.com/f3acd536
> 	You can see on line 15 that after the previous parted command,
> 	/dev/sda3 which existed on line 12 is gone. There are no messages in
> 	dmesg and the partition itself is still on the disk. 

Does the partition still show up in /proc/partitions?  If so this may
be a udev bug.  It's unlikely to be caused by the ATA or IDE drivers
especially since you're not seeing anything in dmesg.  

I'd recommend running "udevadm monitor" in another terminal while you
trigger the bug and send the output to the udev mailing list 
(linux-hotplug@vger.kernel.org)

-jim
