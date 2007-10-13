From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH #upstream 2/2] libata: track SLEEP state and issue SRST to wake it up
Date: Sat, 13 Oct 2007 00:57:59 -0400
Message-ID: <76366b180710122157s506fd467m10181ceca7badf6f@mail.gmail.com>
References: <20071012115631.GA11510@htj.dyndns.org>
	 <20071012115657.GB11510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:22864 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbXJME6B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 00:58:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so969823rvb
        for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 21:58:00 -0700 (PDT)
In-Reply-To: <20071012115657.GB11510@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Tejun,

I'm able to break my system using this patch. I had a hunch this might
be possible.. :) In short, if you issue a sleep command while the
drive is already sleeping, it puts libata into an infinite loop
resetting the port. I've illustrated the working test and the evil
hunch below. The sleep command itself will need a short-circuit out of
this logic in order to prevent this loop.

Also, in the working case below the hddtemp command actually blocked
until the drive was spun up before returning a valid temp. While
testing, I was able to get hddtemp to trigger the drive wake-up when
it was sleeping, but hddtemp then returned stating the drive was
sleeping. Re-running hddtemp until the drive was fully spun up
(another 5 seconds) kept returning that it was sleeping. I'll see if I
can reproduce this reliably. Am I correct in assuming the process
which triggers the wake-up should block?

-Andrew

Working case:

# hddtemp /dev/sdb
/dev/sdb: Hitachi HDS721010KLA330                 : 35 C
# hdparm -Y /dev/sdb

/dev/sdb:
 issuing sleep command
# time hddtemp /dev/sdb
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: waking up from sleep
ata2: soft resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH complete
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
/dev/sdb: Hitachi HDS721010KLA330                 : 34 C
real    0m 10.89s
user    0m 0.00s
sys     0m 0.00s
# time hddtemp /dev/sdb
/dev/sdb: Hitachi HDS721010KLA330                 : 34 C
real    0m 0.26s
user    0m 0.00s
sys     0m 0.00s

Evil DoS case:

# hddtemp /dev/sdb
/dev/sdb: Hitachi HDS721010KLA330                 : 35 C
# hdparm -Y /dev/sdb

/dev/sdb:
 issuing sleep command
# hdparm -Y /dev/sdb
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: waking up from sleep
ata2: soft resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: waking up from sleep
ata2: soft resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH complete
....
to infinity

On 10/12/07, Tejun Heo <htejun@gmail.com> wrote:
> ATA devices in SLEEP mode don't respond to any commands.  SRST is
> necessary to wake it up.  Till now, when a command is issued to a
> device in SLEEP mode, the command times out, which makes EH reset the
> device and retry the command after that, causing a long delay.
>
> This patch makes libata track SLEEP state and issue SRST automatically
> if a command is about to be issued to a device in SLEEP.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
> Cc: Andrew Paprocki <andrew@ishiboo.com>
> ---
>  drivers/ata/libata-core.c |   12 ++++++++++++
>  drivers/ata/libata-eh.c   |    4 +++-
>  include/linux/ata.h       |    1 +
>  include/linux/libata.h    |    1 +
>  4 files changed, 17 insertions(+), 1 deletion(-)
>
> Index: work/include/linux/ata.h
> ===================================================================
> --- work.orig/include/linux/ata.h
> +++ work/include/linux/ata.h
> @@ -179,6 +179,7 @@ enum {
>         ATA_CMD_VERIFY          = 0x40,
>         ATA_CMD_VERIFY_EXT      = 0x42,
>         ATA_CMD_STANDBYNOW1     = 0xE0,
> +       ATA_CMD_SLEEP           = 0xE6,
>         ATA_CMD_IDLEIMMEDIATE   = 0xE1,
>         ATA_CMD_INIT_DEV_PARAMS = 0x91,
>         ATA_CMD_READ_NATIVE_MAX = 0xF8,
> Index: work/include/linux/libata.h
> ===================================================================
> --- work.orig/include/linux/libata.h
> +++ work/include/linux/libata.h
> @@ -145,6 +145,7 @@ enum {
>         ATA_DFLAG_PIO           = (1 << 12), /* device limited to PIO mode */
>         ATA_DFLAG_NCQ_OFF       = (1 << 13), /* device limited to non-NCQ mode */
>         ATA_DFLAG_SPUNDOWN      = (1 << 14), /* XXX: for spindown_compat */
> +       ATA_DFLAG_SLEEPING      = (1 << 15), /* device is sleeping */
>         ATA_DFLAG_INIT_MASK     = (1 << 16) - 1,
>
>         ATA_DFLAG_DETACH        = (1 << 16),
> Index: work/drivers/ata/libata-core.c
> ===================================================================
> --- work.orig/drivers/ata/libata-core.c
> +++ work/drivers/ata/libata-core.c
> @@ -5553,6 +5553,10 @@ void __ata_qc_complete(struct ata_queued
>                 case ATA_CMD_SET_MULTI: /* multi_count changed */
>                         eh_action |= ATA_EH_REVALIDATE;
>                         break;
> +
> +               case ATA_CMD_SLEEP:
> +                       qc->dev->flags |= ATA_DFLAG_SLEEPING;
> +                       break;
>                 }
>
>                 if (unlikely(eh_action) && ap->ops->error_handler) {
> @@ -5757,6 +5761,14 @@ void ata_qc_issue(struct ata_queued_cmd
>                 qc->flags &= ~ATA_QCFLAG_DMAMAP;
>         }
>
> +       /* if device is sleeping, schedule softreset and abort the link */
> +       if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +               link->eh_info.action |= ATA_EH_SOFTRESET;
> +               ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
> +               ata_link_abort(link);
> +               return;
> +       }
> +
>         ap->ops->qc_prep(qc);
>
>         qc->err_mask |= ap->ops->qc_issue(qc);
> Index: work/drivers/ata/libata-eh.c
> ===================================================================
> --- work.orig/drivers/ata/libata-eh.c
> +++ work/drivers/ata/libata-eh.c
> @@ -2207,9 +2207,11 @@ int ata_eh_reset(struct ata_link *link,
>                 ata_link_for_each_dev(dev, link) {
>                         /* After the reset, the device state is PIO 0
>                          * and the controller state is undefined.
> -                        * Record the mode.
> +                        * Reset also wakes up drives from sleeping
> +                        * mode.
>                          */
>                         dev->pio_mode = XFER_PIO_0;
> +                       dev->flags &= ~ATA_DFLAG_SLEEPING;
>
>                         if (ata_link_offline(link))
>                                 continue;
>
>
