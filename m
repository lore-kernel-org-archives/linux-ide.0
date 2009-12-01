From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Tue, 01 Dec 2009 15:04:55 +0900
Message-ID: <4B14B207.9010208@kernel.org>
References: <1258054583-sup-4108@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39950 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbZLAGGK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 01:06:10 -0500
In-Reply-To: <1258054583-sup-4108@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

On 11/13/2009 04:43 AM, Alex Vandiver wrote:
> Heya,
> 
>   I've been seeing intermittent failures of one of the SATA ports on a
> new machine.  I've tried swapping out hard drives and cables, and even
> gotten a new motherboard from Dell, but it seems to persist.  It
> manifests as:
> 
> [    2.512022] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.512037] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.512043] ata2.01: SATA link up <unknown> (SStatus 300 SControl 123)
> [    2.512057] ata2.00: link offline, clearing class 1 to NONE
> [    2.512064] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 
> ata2.00 is always the port which is reset.  The only other person to
> see that error seems to have been Tim Blechmann, in
> <4AC9C373.80603@klingt.org>, which had similar symtoms.  lspci -v for
> this machine's IDE controllers is:

Can you please attach full dmesg output after such event?

-- 
tejun
