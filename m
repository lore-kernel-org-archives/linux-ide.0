From: Alex Vandiver <alex@chmrr.net>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to NONE")
Date: Mon, 21 Dec 2009 14:13:59 -0500
Message-ID: <1261422681-sup-4043@utwig>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org> <4B14D454.7010300@kernel.org> <1259704924-sup-4007@utwig> <4B15C64E.7090106@kernel.org> <1259774491-sup-9212@utwig> <4B17042B.5070400@kernel.org> <4B17095C.50204@kernel.org> <1261167192-sup-3861@utwig> <4B2EFE87.6000206@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chmrr.net ([209.67.253.66]:58155 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757050AbZLUTOA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2009 14:14:00 -0500
In-reply-to: <4B2EFE87.6000206@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide <linux-ide@vger.kernel.org>

At Sun Dec 20 23:50:15 -0500 2009, Tejun Heo wrote:
> Wow, that's unexpected.  Can you please post log of this with the
> debugging patch applied?

I've only been able to replicate this once, and I didn't manage to
save its dmesg, sadly.  I'll see if I can get it to crop up again,
though.

> Hmmm... interesting.  So, the boot time probing is somehow different
> from probing initiated by manual scan (they both use hardreset).  Can
> you please post log of manual scans with debug patch applied?

The output of a manual scan is:

[  255.236938] ata1.00: hard resetting link
[  255.465422] ata1.00: XXX debounce start, SStatus=123
[  257.551239] ata1.00: XXX debounce done, SStatus=123, DET stable for 2090 msecs
[  257.551246] ata1.01: hard resetting link
[  257.780776] ata1.01: XXX debounce start, SStatus=123
[  259.866589] ata1.01: XXX debounce done, SStatus=123, DET stable for 2090 msecs
[  260.026328] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  260.026342] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  260.087511] ata1.00: configured for UDMA/133
[  260.127736] ata1.01: configured for UDMA/133
[  260.127740] ata1: EH complete

 - Alex
-- 
Networking -- only one letter away from not working
