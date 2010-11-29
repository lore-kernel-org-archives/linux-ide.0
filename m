From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [git patches] libata updates for 2.6.37
Date: Mon, 29 Nov 2010 13:07:55 -0500
Message-ID: <20101129180755.GK15818@bombadil.infradead.org>
References: <20101022012302.GA7487@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101022012302.GA7487@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 21, 2010 at 09:23:02PM -0400, Jeff Garzik wrote:
> 1) Link Power Management (LPM) rewrite
> 

Hrm, this is causing issues for me... When I resume from suspend on my
thinkpad X201s I get:

[ 2454.478673] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2454.487736] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
[ 2454.487742] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
filtered out
[repeated a few times]
[ 2454.492688] ata1.00: configured for UDMA/100
[ 2454.506690] ata1.00: configured for UDMA/100
[ 2454.506696] ata1: EH complete
[...]
[ 2455.097874] ata1.00: configured for UDMA/100
[ 2455.097882] ata1: EH complete
[...]
[ 2455.386756] ata1.00: failed to enable DIPM, Emask 0x100
[ 2455.386768] ata1: hard resetting link
[...]
[ 2455.847925] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2455.849372] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES)
succeeded
[ 2455.849380] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[ditto]
[ 2455.854171] ata1.00: configured for UDMA/100
[ 2455.854480] ata1.00: failed to enable DIPM, Emask 0x100
[ 2455.854484] ata1: disabling LPM on the link
[ 2455.854489] ata1: limiting SATA link speed to 1.5 Gbps
[ 2455.854494] ata1.00: limiting speed to UDMA/100:PIO3

Tejun, any ideas how I can debug this?

regards, Kyle
