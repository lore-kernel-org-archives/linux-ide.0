From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/2] ata: Updates for pata_octeon_cf driver.
Date: Fri, 17 Aug 2012 20:19:19 -0400
Message-ID: <502EDF87.4070402@pobox.com>
References: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41856 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab2HRATX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 20:19:23 -0400
In-Reply-To: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: ralf@linux-mips.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

On 08/17/2012 07:54 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> The main update is conversion to device tree.  Now the the OCTEON
> device tree prerequisites are upstream, we can convert the
> pata_octeon_cf driver.
>
> The second change allows the driver to function when the kernel is
> built for little-endian operation.
>
> The only real change in the MIPS portion of the tree is deletion of
> crap.
>
> There is a dependence on patches Ralf has queued in linux-next so it
> may be best to merge via the MIPS tree (as pata_octeon_cf only exists
> in MIPS based OCTEON SOCs).  But the ata tree would be fine by me too.
> In any even we may need some cross sub-system Acked-bys.
>
> David Daney (2):
>    MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
>    ata: pata_octeon_cf: Use correct byte order for DMA in when built
>      little-endian.
>
>   arch/mips/cavium-octeon/octeon-irq.c           |   1 -
>   arch/mips/cavium-octeon/octeon-platform.c      | 102 ------
>   arch/mips/include/asm/mach-cavium-octeon/irq.h |   1 -
>   arch/mips/include/asm/octeon/octeon.h          |   7 -
>   drivers/ata/pata_octeon_cf.c                   | 423 +++++++++++++++++--------
>   5 files changed, 288 insertions(+), 246 deletions(-)

patches 1 and 2 are

Acked-by: Jeff Garzik <jgarzik@redhat.com>



