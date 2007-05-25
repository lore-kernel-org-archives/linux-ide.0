From: Tony Vroon <chainsaw@gentoo.org>
Subject: Re: [patch 03/11] Optional LED trigger for libata
Date: Fri, 25 May 2007 09:36:03 +0100
Message-ID: <46569FF3.2000202@gentoo.org>
References: <200705232126.l4NLQfXT032526@shell0.pdx.osdl.net> <46565758.508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganymede.vroon.org ([195.66.242.11]:54486 "EHLO
	ganymede.vroon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbXEYIpG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 04:45:06 -0400
In-Reply-To: <46565758.508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: htejun@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
>> From: Tony Vroon <chainsaw@gentoo.org>
>>
>> This adds an optional wrapper around ata_ac_issue_prot that triggers the
>> LED layer.  This is used for the PMU LED on G5 towers (IDE trigger).  My
>> test platform is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2
>> (sata_svw) controller.  Now respun as a single patch, and the function
>> name
>> shortened as requested.
>>
>> Signed-off-by: Tony Vroon <chainsaw@gentoo.org>
>> Acked-by: Tejun Heo <htejun@gmail.com>
>> Cc: Jeff Garzik <jeff@garzik.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/ata/libata-core.c |   21 +++++++++++++++++++++
>>  drivers/ata/sata_svw.c    |    2 +-
>>  include/linux/libata.h    |    1 +
>>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> 
> After sitting on this for a time, I still cannot summon any interest in
> taking this patch.  It slows down the hot path for pretty lights.

Jeff,

Would a conditional on ADB_PMU_LED_IDE (instead of the more generic
LEDS_TRIGGER_IDE_DISK) alleviate your concerns? This can only be enabled
on PPC platforms and would make sure that the hot path is not polluted
anywhere else.

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVp/yp5vW4rUFj5oRCOlXAJwMpRiboqDnMcFdHxX7BU+Y1S1SxACePgeP
q4yyJJzNBeJeF1YakPXrIOo=
=ehsX
-----END PGP SIGNATURE-----
