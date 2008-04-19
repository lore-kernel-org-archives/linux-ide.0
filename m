From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-mm1 -- Is this just my drive dying?
Date: Fri, 18 Apr 2008 22:26:40 -0700
Message-ID: <20080418222640.274e2bd9.akpm@linux-foundation.org>
References: <a44ae5cd0804182217y1f94cceeq12115c379de7c58a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35864 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325AbYDSF0x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Apr 2008 01:26:53 -0400
In-Reply-To: <a44ae5cd0804182217y1f94cceeq12115c379de7c58a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


(cc linux-ide)

On Sat, 19 Apr 2008 01:17:00 -0400 "Miles Lane" <miles.lane@gmail.com> wrote:

> [ 6288.201390] ata1.00: configured for UDMA/100
> [ 6288.201428] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE,SUGGEST_OK
> [ 6288.201435] sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
> [ 6288.201445] Descriptor sense data with sense descriptors (in hex):
> [ 6288.201449]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
> [ 6288.201471]         00 94 45 27
> [ 6288.201480] sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error -
> auto reallocate failed
> [ 6288.201489] end_request: I/O error, dev sda, sector 9717031
> [ 6288.201497] Buffer I/O error on device sda1, logical block 1214621
> [ 6288.203810] ata1: EH complete
> [ 6288.203921] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> [ 6288.203973] sd 0:0:0:0: [sda] Write Protect is off
> [ 6288.203979] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 6288.205413] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 6288.275427] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> [ 6288.283499] sd 0:0:0:0: [sda] Write Protect is off
> [ 6288.283511] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 6288.300123] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 6293.184073] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [ 6293.184084] ata1.00: BMDMA stat 0x65
> [ 6293.184093] ata1.00: cmd c8/00:08:27:45:94/00:00:00:00:00/e0 tag 0
> dma 4096 in

Well that's what it's alleging, but of course the kernel could be tricking
you.  Fire up 2.6.25 and give the disk a thrashing, maybe?
