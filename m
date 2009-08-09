From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA errors
Date: Sun, 09 Aug 2009 11:24:45 -0600
Message-ID: <4A7F065D.3090004@gmail.com>
References: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:54333 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZHIRYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 13:24:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so2816432and.1
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 10:24:47 -0700 (PDT)
In-Reply-To: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miah Gregory <mace@darksilence.net>
Cc: linux-ide@vger.kernel.org

On 08/09/2009 04:36 AM, Miah Gregory wrote:
> Hi,
>
> One of my servers has started to log slightly odd errors following one
> of the software RAID arrays having been degraded due to an error on sdb.
>
> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>           res 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4.00: status: { DRDY }
> ata4: hard resetting link
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: configured for UDMA/133
> ata4: EH complete
> sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
> end_request: I/O error, dev sdb, sector 976767834

This is a cache flush request that's timing out, the others are SMART 
requests. Random timeouts are rather hard to diagnose but can often be 
caused by hardware issues. You mentioned you have 4 drives in the 
machine, SATA can be rather sensitive to power issues and it's possible 
the power supply can't handle peak demands from all 4 drives 
simultaneously. Might be something to look into first.
