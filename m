From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Thu, 03 Dec 2009 09:19:55 +0900
Message-ID: <4B17042B.5070400@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org> <4B14D454.7010300@kernel.org> <1259704924-sup-4007@utwig> <4B15C64E.7090106@kernel.org> <1259774491-sup-9212@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40443 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755879AbZLCAUy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Dec 2009 19:20:54 -0500
In-Reply-To: <1259774491-sup-9212@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

On 12/03/2009 02:45 AM, Alex Vandiver wrote:
> At Tue Dec 01 20:43:42 -0500 2009, Tejun Heo wrote:
>> Can you please try this one?
> 
> Good and bad dmesg output attached.

That's interesting.  The link state seems to oscillates for quite long
time.  Can you please try the followings?

1. Change sata_deb_timing_hotplug to sata_deb_timing_long in
   ata_piix.c::piidx_sidpr_hardreset() and see whether it solves the
   problem?

2. Switch the controller into ahci mode in BIOS if possible and see
   whether the problem goes away.

3. Try kernel parameter "libata.force=nohrst" and see whether it makes
   any difference.

Thanks.

-- 
tejun
