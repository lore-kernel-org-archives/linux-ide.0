From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 15 Aug 2007 15:10:05 +0900
Message-ID: <46C298BD.1070600@gmail.com>
References: <36D83AB0-1848-4240-B8FC-D634D9E90B31@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:16359 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXHOGKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 02:10:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1646064rvb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 23:10:19 -0700 (PDT)
In-Reply-To: <36D83AB0-1848-4240-B8FC-D634D9E90B31@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

Hello, Rusty.

Rusty Conover wrote:
> I'm having some trouble with my e-SATA ports being reset.  I'm testing
> 2.6.22.1 with the 20070808 patch tarball on a nortec ds-1220 flashed to
> Silicon Image bios version 6.4.09 (the latest).
> 
> I'm testing with 6 500gig SATA drives shown as:
> 
> WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
> 
> The error I'm getting is:
> 
> ata3.04: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
> ata3.04: cmd 61/00:08:3f:c9:00/04:00:00:00:00/40 tag 1 cdb 0x0 data
> 524288 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link down (SStatus 0 SControl 300)
> ata3.02: hard resetting link
> ata3.02: SATA link down (SStatus 0 SControl 300)
> ata3.03: hard resetting link
> ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.04: hard resetting link
> ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.05: hard resetting link
> ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: configured for UDMA/100
> ata3.03: configured for UDMA/100
> ata3.04: configured for UDMA/100
> ata3: EH complete
> 
> This is happening under moderate load, but it does appear to recover and
> have all of the drives come back.  I'd be happy to provide a full dmesg
> log if desired.
> 
> If you have any ideas how I can work around this or what's causing the
> problem it would be greatly appreciated.

* Please post kernel log including boot messages and errors.

* Please post the result of 'hdparm -I /dev/sdX' where sdX is the
offending device.

* Are the errors localized to ata3.04 or are other drives affected too?

* If you keep the machine running, libata will fall back to 1.5Gbps
after several such errors.  Do the errors go away after falling back to
1.5Gbps?

Thanks.

-- 
tejun
