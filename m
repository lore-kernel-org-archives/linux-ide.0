From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 04 Nov 2008 14:13:34 -0500
Message-ID: <49109EDE.1020803@rtr.ca>
References: <490F4030.5030709@rtr.ca>	 <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>	 <49108F96.8010902@rtr.ca> <87f94c370811041023s3de41ec9o66614bf3f0fdb63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50369 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968AbYKDTMy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 14:12:54 -0500
In-Reply-To: <87f94c370811041023s3de41ec9o66614bf3f0fdb63c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On Tue, Nov 4, 2008 at 1:08 PM, Mark Lord <liml@rtr.ca> wrote:
..
>> Mmm.. never thought about that much before now,
>> but DCO is a nifty way to hide much of a drive from prying eyes.
>> Eg. Use DCO to restrict the drive to LBA28 accessible sectors
>> and also turn off LBA48 support, and then a lot of space becomes "hidden".
>> Until now!
> 
> Yeah, combine that with some HPA shenanigans and you can create two
> complete disk partition layouts on one drive.
> 
> ie. Two partition tables, the normal partition table for the first 128
> GiB is in sector 1.  The partition table for the rest of the disk is
> at sector 128 GiB + 1.  Then use DCO to totally hide the upper section
> of the drive.
> 
> When you want access, use DCO commands to expose it, and then HPA
> commands to make only the sectors beyond 128 GiB accessible.
..

Now that one has me stumped.  The only HPA commands I know of,
permit setting only the maximum-LBA, not the minimum.
Or is this a newish ATA9 (or last-minute ATA8) sort of thing ?
..
> to the end of the disk, then issue a "hpa swap" command.  That will
> hide the first 128 GiB and expose the rest of the disk.
..

Yeah.. what's this "hpa swap" ?  Possibly a vendor-specific op, perhaps?

Cheers
