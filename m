From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 15:45:55 +0200
Message-ID: <46559713.9070201@gmail.com>
References: <4655923E.5000409@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:50901 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbXEXNqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 09:46:18 -0400
Received: by wx-out-0506.google.com with SMTP id t15so353079wxc
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 06:46:17 -0700 (PDT)
In-Reply-To: <4655923E.5000409@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Florian Effenberger wrote:
> We installed Debian Etch with the pre-compiled kernel, but when doing
> heavy SATA data transfer, the drives seem to make trouble. Even with the
> latest kernel, 2.6.21.2, we receive:
> 
> ===
> ata3.00: exception Emask 0x10 SAct 0x1 SErr 0x400100 action 0x2 frozen
> ata3.00: (irq_stat 0x08000000, interface fatal error)
> ata3.00: cmd 61/80:00:00:91:91/00:00:1d:00:00/40 tag 0 cdb 0x0 data
> 65536 out
>          res 40/00:04:00:91:91/00:00:1d:00:00/40 Emask 0x10 (ATA bus error)
> ata3: soft resetting port
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: configured for UDMA/133
> ata3: EH complete
> SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ===

Looks like a genuine transmission/interface error to me.  How often does
this occur?  Please try to connect the drive to another port using and
possibly different power lane.  Also, testing with another drive is a
good way to track down where the problem is.

> MD5 sums of copied files are right and we experience no other problems.
> Is this a driver bug? If so, can I be of any help in debugging it?

Yeah, libata EH is working properly so there shouldn't be any problem
other than the error messages and a bit slower transfer speed.

-- 
tejun
