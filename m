From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA eating my disk, port reset, destroying unrelated data
Date: Mon, 12 Nov 2007 12:57:25 +0900
Message-ID: <4737CF25.6070100@gmail.com>
References: <fa.49dhbrKdHhj8Seg3o+OTGRYqytk@ifi.uio.no> <473256BD.1080205@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:61641 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbXKLD5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 22:57:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1060157rvb
        for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 19:57:33 -0800 (PST)
In-Reply-To: <473256BD.1080205@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Norbert Preining wrote:
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2
> 
> Serror 0x400000 means a handshake error. Usually Serror indications are
> due to a hardware problem (bad SATA cable, power or drive problem).
> 
>> ata1.00: (BMDMA stat 0x25)
>> ata1.00: cmd 35/00:00:2a:6f:c0/00:04:0c:00:00/e0 tag 0 cdb 0x0 data
>> 524288 out
>>          res 51/84:10:1a:72:c0/84:01:0c:00:00/e0 Emask 0x10 (ATA bus
>> error)

And error register value 0x84 - ICRC (CRC error on ATA bus) and ABRT
(command abort) - agrees with what SError indicates.  You're
experiencing transmission errors.

>> ata1: soft resetting port
>> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata1.00: configured for UDMA/133
>> ata1: EH complete
>>
>> Even worse, sometimes the reset does not work ...
>>
>> ata1: device not ready (errno=-16), forcing hardreset
>> ata1: hard resetting port
>> ata1 SRST failed (errno=-19)
>> ata1: reset failed (errno=-19), retrying in 10 secs
>> ..
>>
>> (typed from a digital photo, nothing remains in the logs)
>>
>> After this I need to do a cold boot otherwise the drive is really in a
>> bad state and not even the bios gets it right.
> 
> If even the BIOS cannot reset properly then that also really points to a
> hardware problem..

Also, firmware on some harddrives die solidly when transmission errors
occur.  Maybe yours is one.  There's nothing much the driver can do
about both the transmission error and the drive locking up afterward.
If the transmission errors occur frequently, the chance is that either
your drive or power supply is dying.  As for the drive lock up, maybe
firmware update will help.

* "smartctl -a /dev/sda" might report something interesting.

* Connect the drive to different SATA and power connector and see if the
problem persists.

* Connect the drive to a separate power supply and see if the problem
persists.

-- 
tejun
