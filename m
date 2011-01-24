From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Mon, 24 Jan 2011 18:04:32 +0100
Message-ID: <20110124170432.GH27510@htj.dyndns.org>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51785 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab1AXREh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 12:04:37 -0500
Received: by ewy5 with SMTP id 5so1974554ewy.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 09:04:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 24, 2011 at 04:06:31PM +0000, Dave Howorth wrote:
> Jan  5 22:54:38 piglet kernel: [  228.040099] ata5: hard resetting link
> Jan  5 22:54:38 piglet kernel: [  228.390046] ata5: SATA link up 1.5
> Gbps (SStatus 113 SControl 310)
> Jan  5 22:54:38 piglet kernel: [  228.430286] ata5.00: configured for
> UDMA/66
> Jan  5 22:54:38 piglet kernel: [  228.430309] ata5: EH complete
> 
> You can see that it steadily reduces the bus speed.

Hmmm... there is no message which shows why EH kicked in.  Weird.  Can
you please post the output of dmesg instead after those failures?

> With the new VIA adapter, lspci shows:
> Jan 12 20:51:18 piglet kernel: [  109.441492] ata2.00: exception Emask
> 0x12 SAct 0x0 SErr 0x1000500 action 0x6
> Jan 12 20:51:18 piglet kernel: [  109.441517] ata2.00: BMDMA stat 0x5
> Jan 12 20:51:18 piglet kernel: [  109.441525] ata2: SError: {
> UnrecovData Proto TrStaTrns }
> Jan 12 20:51:18 piglet kernel: [  109.441539] ata2.00: cmd
> c8/00:f0:58:05:57/00:00:00:00:00/e1 tag 0 dma 122880 in
> Jan 12 20:51:18 piglet kernel: [  109.441541]          res
> 51/84:48:00:00:00/84:58:00:00:00/e0 Emask 0x12 (ATA bus error)
> Jan 12 20:51:18 piglet kernel: [  109.441555] ata2.00: status: { DRDY ERR }
> Jan 12 20:51:18 piglet kernel: [  109.441561] ata2.00: error: { ICRC ABRT }
> Jan 12 20:51:18 piglet kernel: [  109.441575] ata2: hard resetting link
> Jan 12 20:51:18 piglet kernel: [  109.746050] ata2: SATA link up 1.5
> Gbps (SStatus 113 SControl 310)
> Jan 12 20:51:18 piglet kernel: [  109.784313] ata2.00: configured for
> UDMA/33
> Jan 12 20:51:18 piglet kernel: [  109.784337] ata2: EH complete
> 
> The errors didn't seem to cause any data corruption.
> 
> Oh and the kernel versions are:
> openSUSE 11.2  2.6.31
> ubuntu 10.04   2.6.32
> knoppix 6.4.3  2.6.36
> 
> Looking at the kernel changelogs I see a 'magic patch' from Joseph Chan
> that was applied between .32 and .36. It is described as improving
> behaviour with WD drives while mine are Samsung. But looking at the
> kernel bugzilla, it seemed to my tyro eyes that the symptoms are similar.
> 
> So I'm curious whether:
> (1) My case is support for wider usefulness of the 'magic patch', or

I doubt it.  The problem is via specific and you seem to be
experiencing similar problem on the sil controller too.

> (2) there was some other kernel change that explains the improved
>     behaviour on my system, or

AFAIK, nope.

> (3) I've misunderstood the evidence and there's something else going on.

It seems like the hardware definitely is flaky.  SATA is one of the
first things which malfunction when the system has has interference
issues.  I have no idea why the new kernel makes it happier tho.

Thanks.

-- 
tejun
