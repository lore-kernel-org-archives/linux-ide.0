From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata and legacy ide pcmcia failure
Date: Fri, 08 Jun 2007 16:10:43 +0900
Message-ID: <466900F3.7040801@gmail.com>
References: <464A0321.3080201@gmail.com>	<464C1575.8070005@gmail.com>	<464CB7C9.2080807@gmail.com>	<46503192.1040300@gmail.com>	<4650B9E3.7070409@gmail.com>	<46518798.2020808@gmail.com>	<4651B66E.6030505@gmail.com>	<4651B834.3060702@gmail.com>	<4651C4A1.6000101@gmail.com>	<4651C74B.7020108@gmail.com>	<46520B36.90409@garzik.org> <20070523150229.00a0c3c4@the-village.bc.nu> <466718B6.4080105@gmail.com> <4667B39D.209@gmail.com> <46685AE5.4010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:6091 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377AbXFHHLB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 03:11:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so927895wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 00:11:00 -0700 (PDT)
In-Reply-To: <46685AE5.4010908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert de Rooy <robert.de.rooy@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, bzolnier@gmail.com, linux-pcmcia@lists.infradead.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

Hello,

Robert de Rooy wrote:
> Jun  7 21:10:28 localhost kernel: ata3: soft resetting port
> Jun  7 21:10:28 localhost kernel: ata3: reset complete
> Jun  7 21:10:28 localhost kernel: ATA: abnormal status 0x80 on port
> 0x00014107
> Jun  7 21:10:28 localhost kernel: ATA: abnormal status 0x80 on port
> 0x00014107
> Jun  7 21:10:28 localhost kernel: ata3.00: issuing IDENTIFY
> Jun  7 21:10:29 localhost kernel: ata3.00: IDENTIFY complete
> Jun  7 21:10:29 localhost kernel: ata3.00: CFA: Memory Card Adapter,
> 20011212, max PIO1
> Jun  7 21:10:29 localhost kernel: ata3.00: 253696 sectors, multi 0: LBA
> Jun  7 21:10:29 localhost kernel: ata3.00: issuing IDENTIFY
> Jun  7 21:10:29 localhost kernel: ata3.00: IDENTIFY complete
> Jun  7 21:10:29 localhost kernel: ata3.00: configured for PIO0
> Jun  7 21:10:29 localhost kernel: ata3: EH complete
> Jun  7 21:10:29 localhost kernel: scsi 3:0:0:0: Direct-Access    
> ATA      Memory Card Adap 2001 PQ: 0 ANSI: 5
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] 253696 512-byte
> hardware sectors (130 MB)
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] Write Protect is off
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] Write cache:
> disabled, read cache: enabled, doesn't support DPO or FUA
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] 253696 512-byte
> hardware sectors (130 MB)
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] Write Protect is off
> Jun  7 21:10:29 localhost kernel: sd 3:0:0:0: [sdd] Write cache:
> disabled, read cache: enabled, doesn't support DPO or FUA

So, that made it go through detection okay.  That's a good news.

> Jun  7 21:10:59 localhost kernel:  sdd:<3>ata3.00: exception Emask 0x0
> SAct 0x0 SErr 0x0 action 0x2 frozen
> Jun  7 21:10:59 localhost kernel: ata3.00: cmd
> 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
> Jun  7 21:10:59 localhost kernel:          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

But, read for partition table failed miserably and took the device
offline completely.

Whee... Cc'ing linux-ide and Mark Lord.  The original thread is..

  http://thread.gmane.org/gmane.linux.kernel/530099

Any ideas?

-- 
tejun
