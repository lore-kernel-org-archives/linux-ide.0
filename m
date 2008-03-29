From: Tejun Heo <htejun@gmail.com>
Subject: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sat, 29 Mar 2008 16:16:53 +0900
Message-ID: <47EDECE5.50309@gmail.com>
References: <20080328093055.GA16736@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:4421 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYC2HRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 03:17:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so340335rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 00:17:00 -0700 (PDT)
In-Reply-To: <20080328093055.GA16736@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, ric@emc.com

Hello, all.

Andi Kleen wrote:
 >
 > I'm attaching them.  They are huge, sorry.
 >
 > This was over multiple attempts with different kernels. Initially
 > it failed just on mounting, then later also developed problems
 > on scanning. I also tried to switch the port around so you see
 > it moving. There were two identical disk on the box, only
 > one failed.
 >
 > I think it started when I hard powered off the machine at some point,
 > the result was a large corrupted chunk in the inode table on the
 > disk (didn't Linus run into a similar problem recently?)

Heh.. that disk is completely toasted.  Probing itself was okay.
Errors occur when someone is trying to access the data on platter -
reading the partition, udev trying to determine persistent names.
Several things to note.

(While writing, the message developed into discussion material, cc'ing
  relevant people.  The log is quite large and can be accessed from
  http://htj.dyndns.org/export/libata-eh.log).

1. Currently timeout for reads and writes is 30secs which is a bit too
    long.  This long default timeout is one of the reasons why IO
    errors take so long to get detected and acted upon.  I think it
    should be in the range of 10-15 second.

2. In the first error case in the log, the device goes offline after
    timing out.  When the device keeps its link up but doesn't respond
    at all, libata takes slightly over 1 minutes before it gives up.
    Combined with the initial 30sec timeout, this can feel quite long.
    This timing is determined by ata_eh_timeouts[] table in
    drivers/ata/libata-eh.c and the current timeout table is the
    shortest it can get while allowing the theoretical worst case with
    a bit of margin.  There are several factors at play here.

    ATA resets are allowed to take up to 30 secs.  Don't ask me why.
    That's the spec.  This is to allow the device to postpone replying
    to reset while spinning up, which simply is a bad design.

    Waiting blindly for 30 + margin seconds for each try doesn't work
    too well because during hotplug or after PHY events, reset protocol
    could get a bit unreliable and the response from device can get
    lost.  In addition, some devices might not respond to reset if it's
    issued before the device indicated readiness (SRST) and some
    controllers can only wait for the initial readiness notificaiton
    from the drive after SRST.  The combined result is that even when
    everything is done right there are times when the driver misses
    reset completion.

    So, to handle the common cases better, libata EH times out resets
    quickly.  The first two tries are 10 seconds each and most devices
    get reset properly before it hits the end of the second reset try
    even if it needs to spin up.  What takes the longest is the third
    try, for which the timeout is 35secs.  This is to allow dumb
    devices which require long silent period after reset is issued and
    have at least one reset try with the timeout suggested by the spec.
    I haven't actually seen such device and it could be that we could
    be paying too much for a problem which doesn't exist.

    If we can lift the 35 sec reset try, we can give up resetting in
    slightly over 30 seconds.  If we reduce the command timeout, the
    whole thing from command issue to device disablement could be done
    in around 50 seconds.

3. Another possible source of delay is command retries after failure.
    sd currently sets retry count to five so every failed IO command is
    retried five times.  I agree with Mark that there isn't much sense
    in retrying a command when the drive already told us that it
    couldn't accomplish it due to media problem.  So, retrying commands
    failed with media error five times is probably not the best action
    to take.

What do you guys think?

Thanks.

-- 
tejun
