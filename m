From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possible Bug in sata_via when trying to burn
Date: Thu, 10 May 2007 14:49:10 +0200
Message-ID: <464314C6.8050802@gmail.com>
References: <46419A8B.2060605@ds.gauner.org> <4641D1AE.3070602@gmail.com> <4641DB20.6030606@ds.gauner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:28804 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761753AbXEJMtX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 08:49:23 -0400
Received: by wr-out-0506.google.com with SMTP id 76so616561wra
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 05:49:22 -0700 (PDT)
In-Reply-To: <4641DB20.6030606@ds.gauner.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Schulz <lkml@ds.gauner.org>
Cc: linux-ide@vger.kernel.org

Dominik Schulz wrote:
> Hi,
> 
> as far as I can see the kernel doesn't complain about anything. Nothing
> in the syslog or anywhere else.
> 
> One thing I forgot to mention: It's no permission problem. I get exactly
> the same output as root.
> 
> I've put the output of
> wodim -VV blank=all -dev=2,0,0

| Executing 'mode select g1' command on Bus 2 Target 0, Lun 0 timeout 40s
| CDB:  55 10 00 00 00 00 00 00 3C 00
| Sending 60 (0x3C) bytes of data.
| Write Data:  00 00 21 00 00 00 00 00 05 32 41 C4 08 00 00 00 00 00 00 00 00 00 00 96 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| Errno: 5 (Input/output error), mode select g1 scsi sendcmd: no error
| CDB:  55 10 00 00 00 00 00 00 3C 00
| status: 0x2 (CHECK CONDITION)
| Sense Bytes: 70 00 04 00 00 00 00 0A 00 00 00 00 08 03 00 00
| Sense Key: 0x4 Hardware Error, Segment 0
| Sense Code: 0x08 Qual 0x03 (logical unit communication crc error (ultra-dma/32)) Fru 0x0
| Sense flags: Blk 0 (not valid) 
| resid: 60
| cmd finished after 0.001s timeout 40s

It seems commands to transfer data to the device suffers transmission
error.  Does the same thing occur even when you're using a SATA
device?  The device is already configured at UDMA/33, so it can't be a
cable detection problem.  Weird....

Just in case, can you try to reseat or replace the cable?  Of the two
IDE connectors, where is the dvd writer connected?

-- 
tejun
