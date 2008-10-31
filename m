From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Fri, 31 Oct 2008 09:20:36 -0400
Message-ID: <87f94c370810310620u77f2b31r85b196d7261ef75f@mail.gmail.com>
References: <20081031054949.GA10474@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:18911 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYJaNUh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2008 09:20:37 -0400
In-Reply-To: <20081031054949.GA10474@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Oct 31, 2008 at 1:49 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Notes:
>
> 1) 1.5TB drive fix from Roland
>
> 2) Tejun's sata_via brings a non-working via configuration thanks to a
>   new facility also being used in recent (ICH9/10) ata_piix.
>
>   Change is longer than one might like, but it accurately describes the
>   hardware now, the previous stuff wasn't working, and the newly added
>   support code shouldn't touch non-broken VIA controllers.
>
>
>
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
>
> to receive the following updates:
>
>  drivers/ata/ata_piix.c    |    1 -
>  drivers/ata/libata-core.c |   11 +++-
>  drivers/ata/sata_via.c    |  155 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/libata.h    |    1 +
>  4 files changed, 152 insertions(+), 16 deletions(-)
>
> Jens Axboe (1):
>      libata: add whitelist for devices with known good pata-sata bridges
>
> Randy Dunlap (1):
>      ATA: remove excess kernel-doc notation
>
> Roland Dreier (1):
>      libata: Avoid overflow in ata_tf_to_lba48() when tf->hba_lbal > 127
>
> Tejun Heo (1):
>      sata_via: fix support for 5287
<snip>

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2ff633c..82af701 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1268,7 +1268,7 @@ u64 ata_tf_to_lba48(const struct ata_taskfile *tf)
>
>        sectors |= ((u64)(tf->hob_lbah & 0xff)) << 40;
>        sectors |= ((u64)(tf->hob_lbam & 0xff)) << 32;
> -       sectors |= (tf->hob_lbal & 0xff) << 24;
> +       sectors |= ((u64)(tf->hob_lbal & 0xff)) << 24;
>        sectors |= (tf->lbah & 0xff) << 16;
>        sectors |= (tf->lbam & 0xff) << 8;
>        sectors |= (tf->lbal & 0xff);
<snip>

That looks really serious.

What happens with all previous / stable kernels when connecting up a
1.5TB drive and the user tries to use the last portion of the drive?

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
