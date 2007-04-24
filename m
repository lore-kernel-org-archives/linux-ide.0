From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip FLUSH and STADNBYNOW1 during shutdown if
 device is already spun down
Date: Tue, 24 Apr 2007 11:22:00 +0900
Message-ID: <462D69C8.5050201@gmail.com>
References: <20070423191202.GO10619@htj.dyndns.org> <20070423191257.GP10619@htj.dyndns.org> <462D4041.7030508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:64586 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161024AbXDXCXA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 22:23:00 -0400
Received: by an-out-0708.google.com with SMTP id b33so2065957ana
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 19:22:59 -0700 (PDT)
In-Reply-To: <462D4041.7030508@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, linux-ide@vger.kernel.org, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Robert Hancock wrote:
>> This patch makes libata skip FLUSH and STANDBYNOW1 during shutdown if
>> the drive is already spun down.  Note that whether FLUSH has been
>> performed is not checked.  This is because some userland shutdown(8)'s
>> only do STANDBYNOW1.  Transition to standby mode implies cache flush,
>> so this should be safe.
> 
> Are we sure this is true in all cases? The ATA spec doesn't explicitly
> say that STANDBY IMMEDIATE implies a cache flush. Granted it would be
> retarded for a drive to spin itself down with data still pending in the
> write cache, but firmware people have done some strange things..

I was somehow thinking the ATA spec requires cache flush on entering
STANDBY.  Can't find anything about it now, which means shutdown(8) on
my debian is broken.  :-(

>> +    /* Set spundown status.  Some userland tools use STANDBY
>> +     * instead of STANDBYNOW1.  Take both into account.
>> +     */
>> +    if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
>> +             qc->tf.command == ATA_CMD_STANDBYNOW1))
>> +        adev->flags |= ATA_DFLAG_SPUNDOWN;
> 
> Is checking for STANDBY really valid here? STANDBY does not do an
> immediate entry to standby mode, it only sets the standby timer.
> Therefore just because userspace issued a standby command, does not mean
> the drive is really spun down currently.

Heh heh, got you.  STANDBY does put the device into STANDBY mode
immediately.  It's STANDBY_IMMEDIATE + timer adjustment.

> Could we use CHECK POWER MODE to see if the drive is currently spun down
> rather than tracking whether a standby was already issued? That would
> handle the case above as well, we could tell if the drive had actually
> spun down on a timer or not.

Thought about that but that would require passing shutdown
STANDBY_IMMEDIATE to EH and do multi command sequence there.  It can be
done but I think it's too complex.

Gee...  We're in trouble.  It's just too dangerous to skip FLUSH if
STANDBY doesn't imply FLUSH and some dists don't do FLUSH in front of
STANDBY.  I think the best way would be implementing the original compat
kernel parameter and printing big fat warning message to tell the user
that their shutdown(8) needs to be updated.  Any better ideas?

-- 
tejun
