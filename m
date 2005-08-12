From: Douglas Gilbert <dougg@torque.net>
Subject: Re: libata for SATA HDs.
Date: Fri, 12 Aug 2005 11:04:02 +1000
Message-ID: <42FBF582.1070205@torque.net>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zorg.st.net.au ([203.16.233.9]:392 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932350AbVHLBEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 21:04:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.st.net.au (Postfix) with ESMTP id 5AB07394993
	for <linux-ide@vger.kernel.org>; Fri, 12 Aug 2005 11:04:29 +1000 (EST)
Received: from [192.168.48.80] (dsl-58.2.240.220.rns01-kent-syd.dsl.comindico.com.au [220.240.2.58])
	by borg.st.net.au (Postfix) with ESMTP id 12A38394991
	for <linux-ide@vger.kernel.org>; Fri, 12 Aug 2005 11:04:24 +1000 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord wrote:
> James Courtier-Dutton wrote:
>
>> Google did not help me.
>>
>> Can I use the kernel libata and do commands like this now? :
>> hdparm -S60 /dev/sda
>
>
> Yes, but only if you manually apply the "libata-passthru" patch.
<snip>

For those occasions when libata is one box removed
(e.g. sitting in an enclosure) there is a SCSI way
to do "hdparm -S60" (i.e. set standby timer to 300
seconds). That is via the Power Condition mode page.
Changing the relevant fields in that mode page requires
libata to implement the SCSI MODE SELECT command.
Once that command is implemented the Writeback Cache
Enable (WCE) bit in the Caching mode page could also
be controlled.
With MODE SELECT implemented in libata, the equivalent
to "hdparm -S60" would be more longwinded:
  sdparm -s STANDBY=1,SCT=3000 /dev/sda

Jeff has just accepted a patch into libata to implement
the START STOP UNIT SCSI command. So soon it will be
possible to place a SATA disk in standby mode immediately
with:
  sdparm -C stop /dev/sda
Any media access command (or "sdparm -C start") will spin
it up again.

Also the SCSI-ATA Translation draft (SAT) defines two
SCSI commands to pass-through ATA commands. smartmontools
could be made to use these (with an option similar to
"-d ata").
A while back Jeff had some patches for those SCSI
pass-through ATA commands but they don't seem to have
made it into the mainline libata.

Doug Gilbert
