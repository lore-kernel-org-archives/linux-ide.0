From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Compact Flash PIO 4 tuning
Date: Tue, 6 May 2003 07:47:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030506074734.C2287@ucw.cz>
References: <m3llxkyjxs.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twilight.ucw.cz ([81.30.235.3]:8663 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262376AbTEFFfJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2003 01:35:09 -0400
Content-Disposition: inline
In-Reply-To: <m3llxkyjxs.fsf@bfnet.com>; from dave-gnus@bfnet.com on Mon, May 05, 2003 at 05:53:35PM -0700
List-Id: linux-ide@vger.kernel.org
To: David Wuertele <dave-gnus@bfnet.com>
Cc: linux-ide@vger.kernel.org

On Mon, May 05, 2003 at 05:53:35PM -0700, David Wuertele wrote:
> Howdy,
> 
> I'm working on an embedded system that has a CF card on the IDE bus.
> The CF spec only allows PIO mode, and my card can do PIO 4.  However,
> when I try to stream data from this card into memory at 2 MBytes per
> second, it pegs the CPU at 100%.  This is ruining the performance of
> my application, which has to process this data in real time.
> 
> I realize that PIO 4 requires CPU involvement, but are there ways I
> can tune the kernel for copying large files to memory, so that my
> application doesn't get starved of CPU?

If you use the full bandwidth of the PIO device, you use 100% CPU.
That's it and there's no way around. You can check that the IDE/CF
interface is set to PIO4 and that under Linux you have IRQ unmasking
enabled, those two will help, though the first statement is still
valid.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
