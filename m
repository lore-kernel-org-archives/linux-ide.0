From: Tejun Heo <tj@kernel.org>
Subject: Re: Drive failure and ASUS
Date: Mon, 24 Nov 2008 14:25:22 +0900
Message-ID: <492A3AC2.5020801@kernel.org>
References: <200811220901.33596.gene.heskett@gmail.com> <4928B36B.5030005@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42895 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbYKXFZ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:25:28 -0500
In-Reply-To: <4928B36B.5030005@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Gene Heskett wrote:
>> Greetings;
>>
>> The only way I can get this box to boot is to disconnect the data
>> cable on a drive with 121 badblocks as somehow ASUS and JMicron-pata
>> all seem to think its /dev/sda when hooked up, and it is no longer
>> bootable.  I'm presently booted from a sata drive on that interface,
>> which this ASUS board has about 8 of.
> 
> The bad disk is PATA?
> 
>>
>> So I've booted with the data cable off, and hooked it up once booted. 
>> Unforch there seems to be no discovery of its presence.
>>
>> No /dev/sdd stuff was created when I plugged the data cable into the
>> drive.
>>
>> The install is the August 2008 F8 respin and is uptodate.
>>
>> How can I make the system aware that it is now there?  It has about 40
>> Gb of data I'd like to recover if I can.

echo "- - -" > /sys/class/scsi_host/host*/scan

> Hotplug isn't supported with PATA, so you shouldn't really try that.
> Fedora installs usually use labels for the disk partitions, so it
> shouldn't matter what device node the disk gets detected as?

It isn't but if you're willing to accept the risk of frying the
controller and/or the drive, it works.  I sometimes do that which
sometimes makes the whole machine shut off instantly.  :-)

-- 
tejun
