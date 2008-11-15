From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv, io stucks
Date: Sat, 15 Nov 2008 16:35:18 -0500
Message-ID: <491F4096.9090701@rtr.ca>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52421 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYKOVe3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Nov 2008 16:34:29 -0500
In-Reply-To: <491EE84B.1010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org

Harri Olin wrote:
> Mark Lord wrote:
>>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>>> different disks, kernel 2.6.26.5.
>>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>>> repeated
>>>>
>>>>
>>>> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 
>>>> action 0x6 frozen
>>>> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 tag 
>>>> 0 ncq 4096 out
>>>> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 
>>>> Emask 0x4 (timeout)
>>>> [  289.851774] ata11.00: status: { DRDY }
>>>> [  289.851834] ata11: hard resetting link
>>>> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>>> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
>>>> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
>>>> [  290.809194] ata11.00: configured for UDMA/133
>>>> [  290.809200] ata11: EH complete
>>>> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware 
>>>> sectors (1000205 MB)
>>>> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
>>>> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
>>>> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read cache: 
>>>> enabled, doesn't support DPO or FUA
>> ...
>>
>> I've just returned here from a month holiday in Italy,
>> and I'll have a look at this and other sata_mv issues
>> next week or so.
> 
> I ran git-bisect on it and it returned 
> a3718c1f230240361ed92d3e53342df0ff7efa8c as first bad commit. Also 
> verified by hand that patching it on working tree breaks it.
..

Wow.. thanks for all of the hard work there.

So it has something to do with (qc->tf.flags & ATA_TFLAG_POLLING).
But what I don't see (yet), is exactly which path through
the driver is reporting this error.

Any path through mv_unexpected_intr() should have the
string "unexpected device interrupt" as part of the error report.

Similarly, any path through mv_err_intr() should have
the string "edma_err_cause=xxxxxxxx" in the error report.

I see neither.  So I wonder what path is being taken
through the driver that results in the error?
(That's the trouble with having been away from the code for five months..).

Since cmd 61 is an NCQ write, it pretty much has to be in EDMA mode,
which means it will likely be calling mv_process_crpb_entries()
and then dropping through to check ERR_IRQ and DEV_IRQ.

The old code checked ERR_IRQ above, and never saw it,
so the new code is probably not seeing ERR_IRQ either.

So it must be seeing DEV_IRQ after process_crpb_entries(),
something that the old code never checked for.
And which is not supposed to happen here.

Weird.

Looking at later kernels (after the commit in question), I see that
the code was further fixed to remove some possible races and stuff,
but that's still just 2.6.26.5, which you guys see failures on.

So here's some instrumentation to help us figure it out.
Please apply and report back once it triggers again.
Thanks.


--- linux-2.6.26.5/drivers/ata/sata_mv.c	2008-09-08 13:40:20.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-11-15 16:32:23.000000000 -0500
@@ -1999,12 +1999,15 @@
 				 * Error will be seen/handled by mv_err_intr().
 				 * So do nothing at all here.
 				 */
+				ata_port_printk(ap, KERN_WARNING, "mv_process_crpb_response1: err_cause=0x%x\n", err_cause);
 				return;
 			}
 		}
 		ata_status = edma_status >> CRPB_FLAG_STATUS_SHIFT;
 		if (!ac_err_mask(ata_status))
 			ata_qc_complete(qc);
+		else
+			ata_port_printk(ap, KERN_WARNING, "mv_process_crpb_response2: edma_status=0x%x\n", edma_status);
 		/* else: leave it for mv_err_intr() */
 	} else {
 		ata_port_printk(ap, KERN_ERR, "%s: no qc for tag=%d\n",
@@ -2070,20 +2073,25 @@
 	 */
 	if (edma_was_enabled && (port_cause & DONE_IRQ)) {
 		mv_process_crpb_entries(ap, pp);
-		if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)
+		if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
+			ata_port_printk(ap, KERN_WARNING, "mv_port_intr1: port_cause=0x%x(ERR_IRQ), ppflags=0x%x\n", port_cause, pp->pp_flags);
 			mv_handle_fbs_ncq_dev_err(ap);
+		}
 	}
 	/*
 	 * Handle chip-reported errors, or continue on to handle PIO.
 	 */
 	if (unlikely(port_cause & ERR_IRQ)) {
+		ata_port_printk(ap, KERN_WARNING, "mv_port_intr2: port_cause=0x%x(ERR_IRQ), edma=%d, ppflags=0x%x\n", port_cause, edma_was_enabled, pp->pp_flags);
 		mv_err_intr(ap);
 	} else if (!edma_was_enabled) {
 		struct ata_queued_cmd *qc = mv_get_active_qc(ap);
 		if (qc)
 			ata_sff_host_intr(ap, qc);
-		else
+		else {
+			ata_port_printk(ap, KERN_WARNING, "mv_port_intr3: port_cause=0x%x(ERR_IRQ), ppflags=0x%x\n", port_cause, pp->pp_flags);
 			mv_unexpected_intr(ap, edma_was_enabled);
+		}
 	}
 }
 
