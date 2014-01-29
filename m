From: Tejun Heo <tj@kernel.org>
Subject: Re: additional model for sata_sil Mod15Write list
Date: Wed, 29 Jan 2014 13:32:42 -0500
Message-ID: <20140129183242.GO30842@htj.dyndns.org>
References: <201401211912.s0LJCk7F015058@rs103.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:37823 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaA2Scq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2014 13:32:46 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so3303593qcq.22
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2014 10:32:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201401211912.s0LJCk7F015058@rs103.luxsci.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: matson <lists-matsonpa@luxsci.me>
Cc: linux-ide@vger.kernel.org

Hello,

Sorry about the delay.

So, this has been reported to me privately a while ago and the
behavioral pattern seems to strongly suggest that it actually is the
same Mod15Write issue.  Matson, can you please post the results of
dd tries with varying io sizes from your previous email?

On Tue, Jan 21, 2014 at 07:12:46PM +0000, matson wrote:
> I have a SiI3112 rev 2 and a Toshiba MK2561GSYN HDD.  I think it
> belongs in the list of buggy drives which require Mod15Write.
> 
> To test, I perform:
> dd if=/dev/zero of=/dev/sdb oflag=direct bs=8192
> Without enabling slow_down, after moment of pause, this shows up in dmesg:
> 
> ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata7.00: failed command: WRITE DMA
> ata7.00: cmd ca/00:10:80:01:00/00:00:00:00:00/e0 tag 0 dma 8192 out
>           res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata7.00: status: { DRDY }
> ata7: hard resetting link
> ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata7.00: configured for UDMA/100
> ata7.00: device reported invalid CHS sector 0
> ata7: EH complete
> 
> If I use slow_down, these timeouts are gone completely.  If I write
> 7680 (15 sector), repeated 100000 times, it is okay.  Reading any
> size is okay.  All of my other drives behave with this card.
> 
> My HDD is HP part 625239, firmware is MH000C.  I do know whether

I suppose you meant to write "do not know"?

> other models (in the series) or firmwares have this problem.
> 
> The following drives are in series TOSHIBA MKxx61GSYN:
> MK1661GSYN MK2561GSYN MK3261GSYN MK5061GSYN MK6461GSYN

Can you please post the output "hdparm -I" on your device?

> I searched for pictures on the Web, and found that these models used
> by Dell have firmware MH000D, and some others have firmware MH000A
> (maybe these are retail).
> 
> MKxx61GSYN listed as current, not discontinued, at Toshiba's Web site.
> 
> http://storage.toshiba.com/storagesolutions/pc-notebook/mkxx61gsyn-series

I'm a bit hesitant to mark all drives in the series with Mod15Write
without testing.  Hmmm...

Thanks!

-- 
tejun
