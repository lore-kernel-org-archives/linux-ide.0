From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI w/ATAPI device problems on Intel Tolapai
Date: Thu, 24 Apr 2008 12:13:29 +0900
Message-ID: <480FFAD9.5040606@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070294E5FA@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:41704 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbYDXDNm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 23:13:42 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2502583wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 20:13:39 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE070294E5FA@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> Hello,
> 
> I am seeing the follow messages in dmesg, when running in AHCI mode with
> a SATA ATAPI device connected, on an Intel Tolapai SoC.  If I just use
> HD's, I don't see this problem.  If I swith it to SATA IDE mode,
> everything seems to work fine.  I also noticed that while in AHCI mode,
> that booting hangs out on Starting udev for several minutes.  I don't
> see this in IDE mode.  This was using the 2.6.25 kernel.
> 
> Any ideas what may be going on or how to fix it?  Please let me know
> what I can try and what other information will help.
> 
> ata1.00: limiting speed to PIO4
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for PIO4
> ata1: EH complete
> ata1.00: limiting speed to PIO3
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for PIO3
> ata1: EH complete
> ata1.00: limiting speed to PIO0
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>          cdb 1e 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)

Hmm.. these look like media presence polling commands from haldaemon.  I 
have no idea why it's failing on ahci tho.  All polling failures I've 
seen till now was device dependent, not controller.  You can disable 
media presence polling using hal-disable-polling /dev/sr0.  If you 
disabling polling, does the device work correctly?  ie. can you read and 
record using it?

-- 
tejun
