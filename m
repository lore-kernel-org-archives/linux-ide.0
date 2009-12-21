From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Mon, 21 Dec 2009 13:50:15 +0900
Message-ID: <4B2EFE87.6000206@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org> <4B14D454.7010300@kernel.org> <1259704924-sup-4007@utwig> <4B15C64E.7090106@kernel.org> <1259774491-sup-9212@utwig> <4B17042B.5070400@kernel.org> <4B17095C.50204@kernel.org> <1261167192-sup-3861@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33151 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbZLUEsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Dec 2009 23:48:33 -0500
In-Reply-To: <1261167192-sup-3861@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

Hello,

On 12/19/2009 08:26 AM, Alex Vandiver wrote:
> On 12/03/2009 09:19 AM, Tejun Heo wrote:
>> 1. Change sata_deb_timing_hotplug to sata_deb_timing_long in
>>    ata_piix.c::piidx_sidpr_hardreset() and see whether it solves the
>>    problem?
> 
> Nope -- in fact, _three_ of the drives failed to come up once, with
> this change.

Wow, that's unexpected.  Can you please post log of this with the
debugging patch applied?

>> 2. Switch the controller into ahci mode in BIOS if possible and see
>>    whether the problem goes away.
> 
> Sadly, the BIOS doesn't have an option for this.

Ah... that's sad.

>> 3. Try kernel parameter "libata.force=nohrst" and see whether it makes
>>    any difference.
> 
> I wasn't able to replicate the problem with this kernel parameter.
> dmesg for such a boot is attached.

Alright, thanks for verifying.

>> 4. You can tell libata to reset the port by running the following command.
>>
>>    echo "- - -" > /sys/class/scsi_host/hostN/scan
>>
>>    N would be 0 or 1 on your configuration.  Can you please run the
>>    above command repeatedly and see whether it triggers a reset
>>    failure?  If so, the above will be far more convenient way to test
>>    than rebooting repeatedly.
> 
> I wasn't able to get this to fail, sadly.  If the boot _had_ failed,
> however, this technique did bring the drive online.

Hmmm... interesting.  So, the boot time probing is somehow different
from probing initiated by manual scan (they both use hardreset).  Can
you please post log of manual scans with debug patch applied?

Thanks.

-- 
tejun
