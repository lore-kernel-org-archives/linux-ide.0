From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata for SATA HDs.
Date: Wed, 10 Aug 2005 23:21:15 -0400
Message-ID: <42FAC42B.5080705@pobox.com>
References: <CA45571DE57E1C45BF3552118BA92C9D060AA3@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:4003 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932221AbVHKDVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:21:19 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D060AA3@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Mark Lord <liml@rtr.ca>, James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Timothy Thelin wrote:
>>>>>>Yes, but only if you manually apply the "libata-passthru" patch.
>>>>>
>>>>>So, why hasn't that patch got into the kernel?
>>>>
>>>>Because there are several reports of it causing problems, when used on a
>>>>loaded system.
> 
> 
>>Please post more information about these "problems".
> 
> 
>>I wonder if it might be another occurance of the libata eh lockups.
>>Those are NOT unique to ATAPI -- the lockups can happen anytime
>>the libata eh code is run, like on a busy RAID, or "loaded system"
>>suffering failed "passthru" commands.
>>
>>Perhaps kill a couple of birds with one stone, if we're lucky.
> 
> 
> I figured I should give my $.02 =)
> 
> I've noticed some bugs with the passthru implementation and have been
> working on some fixes using a custom slax live cd.  I'm in the process of
> fixing and creating multiple patches, which I was going to post to this
> list.
> 
> In particular this is what I've found so far:
> 1) The sense buffer returned when the "check condition" bit is active is
> incorrect
>    - The status and error registers values returned are the command and
> features registers sent in (they never get updated from the device after the
> command is done).
>    - The additional length field is 14 but it should be 12
> 2) The offline bit is ignored
> 3) The length fields are ignored
> 4) Not all the cdb protocols are implemented
> 
> 
> Item 1: This is trivial to fix (note that the bug also exists when
> generating the fixed length sense buffer)
> Item 2: This is important for lower level vendor commands, and its inclusion
> helps mean the difference between staying in linux or rebooting to dos.
> Companies / Users are becomming less inclined to do the latter =)
> Item 3: I don't know how important 3 is to fix considering you will have the
> scsi layer's length info in addition to the cdbs length info.  Maybe just a
> check to make sure they match, and if they don't, abort the cdb.

Feel free to send patches to fix these :)


> Item 4: Considering the passthru spec lists all the protocols, they should
> get implemented.  Otherwise apps wanting to use the passthru mechanism are
> going to be blind that protocols are not implemented.  Alternatively, there
> could be a way to (1) identify the backend is libata so it can be
> special-cased (maybe a "get version" ioctl), and (2) have a means to probe
> libata to find out what is and is not implemented at runtime (maybe extra
> information on the "get version" ioctl).

I would prefer simply to implement all the protocols.  For protocols 
which transport reset-style mechanisms such as SRST, this may take some 
work over and above simply issuing the command to the device.  You may 
need to re-issue IDENTIFY DEVICE, quiesce the bus, etc.

	Jeff



