From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata updates for 2.6.37
Date: Tue, 30 Nov 2010 15:13:58 +0100
Message-ID: <4CF506A6.4020200@kernel.org>
References: <20101022012302.GA7487@havoc.gtf.org> <20101129180755.GK15818@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44314 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab0K3OOO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Nov 2010 09:14:14 -0500
In-Reply-To: <20101129180755.GK15818@bombadil.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello,

On 11/29/2010 07:07 PM, Kyle McMartin wrote:
> On Thu, Oct 21, 2010 at 09:23:02PM -0400, Jeff Garzik wrote:
>> 1) Link Power Management (LPM) rewrite
>>
> 
> Hrm, this is causing issues for me... When I resume from suspend on my
> thinkpad X201s I get:
> 
> [ 2454.478673] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 2454.487736] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
> succeeded
> [ 2454.487742] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> filtered out
> [repeated a few times]
> [ 2454.492688] ata1.00: configured for UDMA/100
> [ 2454.506690] ata1.00: configured for UDMA/100
> [ 2454.506696] ata1: EH complete
> [...]
> [ 2455.097874] ata1.00: configured for UDMA/100
> [ 2455.097882] ata1: EH complete
> [...]
> [ 2455.386756] ata1.00: failed to enable DIPM, Emask 0x100
> [ 2455.386768] ata1: hard resetting link
> [...]
> [ 2455.847925] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 2455.849372] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
> succeeded
> [ 2455.849380] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
> LOCK) filtered out
> [ditto]
> [ 2455.854171] ata1.00: configured for UDMA/100
> [ 2455.854480] ata1.00: failed to enable DIPM, Emask 0x100
> [ 2455.854484] ata1: disabling LPM on the link
> [ 2455.854489] ata1: limiting SATA link speed to 1.5 Gbps
> [ 2455.854494] ata1.00: limiting speed to UDMA/100:PIO3
> 
> Tejun, any ideas how I can debug this?

Hmm... DIPM commands are failing with AC_ERR_OTHER.  Other than DIPM
not being configured and speed capped at 1.5Gbps, the machine works
fine afterwards, right?  Are you up for applying debug patches?

Thanks.

-- 
tejun
