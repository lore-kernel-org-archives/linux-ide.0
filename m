From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata Sil3512 bug?
Date: Thu, 18 Oct 2007 12:29:48 +0900
Message-ID: <4716D32C.5090408@gmail.com>
References: <1097480701.20070927155135@zonnet.nl> <46FCF2A1.30204@gmail.com> <1619914792.20070928172536@zonnet.nl> <20070928165150.2a93524e@the-village.bc.nu> <46FD3213.6050204@gmail.com> <1128907118.20071002212023@zonnet.nl> <47044176.80803@gmail.com> <193014791.20071013183617@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:6335 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761222AbXJRD35 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 23:29:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so36538rvb
        for <linux-ide@vger.kernel.org>; Wed, 17 Oct 2007 20:29:56 -0700 (PDT)
In-Reply-To: <193014791.20071013183617@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

MisterE wrote:
> Oct 13 13:01:26 fileserver kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x0
> Oct 13 13:01:26 fileserver kernel: ata4.00: (BMDMA2 stat 0x650001)
> Oct 13 13:01:26 fileserver kernel: ata4.00: cmd ca/00:f8:47:e1:5e/00:00:00:00:00/e4 tag 0 cdb 0x0 data 126976 out
> Oct 13 13:01:26 fileserver kernel:          res 51/04:98:a7:e1:5e/00:00:00:00:00/e4 Emask 0x1 (device error)
> Oct 13 13:01:26 fileserver kernel: ata4.00: configured for UDMA/100
> Oct 13 13:01:26 fileserver kernel: ata4: EH complete
> Oct 13 13:01:26 fileserver kernel: sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
> Oct 13 13:01:26 fileserver kernel: sd 3:0:0:0: [sdd] Write Protect is off
> Oct 13 13:01:26 fileserver kernel: sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> Oct 13 13:01:26 fileserver kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> I'm not sure if it will result in corrupt data? But i don't trust it
> anymore.

That looks like a data transmission error.  When you're transferring
massive amount of data, things like that can happen and it won't cause
data corruption.

> You people advise me to not buy the Promise SATA300 TX4 controller and
> this Sweex PU102 (3512) seems to have problems. Not much choices left
> except the really expensive solutions.
> 
> Is it really so hard to build a controller without problems?!? :(

It seems so. :-(

-- 
tejun
