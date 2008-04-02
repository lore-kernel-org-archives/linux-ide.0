From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 09:57:29 -0400
Message-ID: <20080402135729.GB24239@csclub.uwaterloo.ca>
References: <200804021524.27222.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:33597 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753073AbYDBN5a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 09:57:30 -0400
Content-Disposition: inline
In-Reply-To: <200804021524.27222.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, Apr 02, 2008 at 03:24:26PM +0200, Frans Pop wrote:
> We've received an installation report for Debian for an older system where
> no IDE driver gets loaded. The system does not have any IDE device listed in
> lspci. When ide-generic is modprobed manually, both the CD and hard disk
> work fine.
> 
> Any suggestions on how such a system could be recognized?
> If we could do that, the installation system could take responsibility for
> loading ide-generic and making sure it is included in the initrd.
> 
> Or even better, any chance to make the kernel/udev load ide-generic
> automatically for this system?
> 
> See http://bugs.debian.org/472487 for details. I can get additional info
> from the owner of the system if needed.
> 
> Cheers,
> FJP
> 
> Output of lspci -nn:
> 00:00.0 Host bridge [0600]: Toshiba America Info Systems CPU to PCI bridge [1179:0601] 
> (rev a0)
> 00:04.0 VGA compatible controller [0300]: Chips and Technologies F65555 HiQVPro 
> [102c:00e5] (rev c6)
> 00:0b.0 USB Controller [0c03]: NEC Corporation USB [1033:0035] (rev 02)
> 00:11.0 Communication controller [0780]: Toshiba America Info Systems FIR Port 
> [1179:0701] (rev 21)
> 00:13.0 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97 [1179:060f] (rev 
> 20)
> 00:13.1 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97 [1179:060f] (rev 
> 20)

How old is that system?  Maybe the IDE isn't even PCI based.  That would
explain why nothing shows in lspci, but the IDE ports are still present
and working.

One could always just manually tell the system to always load
ide-generic, since deciding what to load does seem to be a userspace
choice these days.

-- 
Len Sorensen
