From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Mon, 2 May 2005 10:56:54 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEC10@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:49704 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261349AbVEBP4z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2005 11:56:55 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 5/2/05, Stuart_Hayes@dell.com <Stuart_Hayes@dell.com> wrote:
>> Jens Axboe wrote:
>>> On Fri, Apr 29 2005, Stuart_Hayes@Dell.com wrote:
>>>>> With more testing, I've discovered a problem with thin patch--I
>>>>> used the "KM_USER0" window for kmap_atomic(), but that's
>>>>> apparently not safe to use in an interrupt handler, because there
>>>>> are places in the kernel where KM_USER0 is used without masking
>>>>> interrupts (see include/linux/highmem.h for several examples).
>>>>> This patch is identical to the previous one I sent in, except it
>>>>> uses the KM_IRQ0 window, which I verified is not used anywhere
>>>>> without IRQs masked. 
>>>>> 
>>>>> This patch is against 2.6.11.7... the latest kernel on kernel.org
>>>>> didn't yet have the previous patch I submitted.  If it would be
>>>>> more useful, I can make this patch against an ide-scsi.c that
>>>>> already has my previous patch applied--I wasn't sure which would
>>>>> be better. 
>>> 
>>> (you should inline the patch so one can comment on it...)
>>> 
>>> The IO code typically uses the BIO defines for this.
>>> 
>>> diff -purN linux-2.6.11.7/drivers/scsi/ide-scsi.c
>>> linux-2.6.11.7mods/drivers/scsi/ide-scsi.c ---
>>> linux-2.6.11.7/drivers/scsi/ide-scsi.c        2005-04-07
>>> 14:57:46.000000000 -0400 +++
>>>       linux-2.6.11.7mods/drivers/scsi/ide-scsi.c  2005-04-29
>>>       11:46:55.000000000 -0400 @@ -143,6 +143,9 @@ static void
>>> idescsi_input_buffers (ide_d  { int count; char *buf; +#ifdef
>>> CONFIG_HIGHMEM +     unsigned long flags; +#endif
>>> 
>>>       while (bcount) {
>>>               if (pc->sg - (struct scatterlist *)
>>>                       pc->scsi_cmd->request_buffer >
>>>               pc->scsi_cmd->use_sg) { @@ -151,8 +154,15 @@ static
>>>               void idescsi_input_buffers (ide_d return; } count =
>>> min(pc->sg->length - pc->b_count, bcount); -             buf =
>>> page_address(pc->sg->page) + pc->sg->offset; +#ifdef CONFIG_HIGHMEM
>>> +             local_irq_save(flags); #endif 
>>> 
>>> This is just aweful, don't add tons of ifdefs. If you must
>>> differentiate, just do something ala:
>>> 
>>>         if (PageHighMem(page)) {
>>>                 save interrupts
>>>                 buf = kmap
>>>         } else
>>>                 buf = page_address(xxx).
>>> 
>>> and so on. But why are you still doing it this way? Did we not agree
>>> that adding a host template no-high-mem defines was way better??
>> 
>> The ifdefs were at Bart's request.
> 
> Yep, ifdefs are my fault.
> 
> Thanks for PageHighMem() hint Jens, we should use it also for
> ide-taskfile.c. 
> 
>> The reason I went back to the kmap_atomic() fix instead of adding a
>> no-high-mem flag in the host is that I couldn't get James to accept
>> that
> 
> What is no-high-mem flag?

When I first submitted this patch (to linux-scsi--I wasn't aware at the
time that ide-scsi was maintained as part of ide), Jens suggested a
different way of fixing this problem.  Instead of using kmap_atomic() in
the ide-scsi interrupt handler when doing PIO, he suggested adding a
"bounce_high" flag to the "struct Scsi_Host".  This flag would be set in
idescsi_attach() when the host was being set up.  Then,
scsi_calculate_bounce_limit() would be modified to return
BLK_BOUNCE_HIGH if this flag was set (and the bounce limit wasn't
already set lower than that), so that any scatter gather pages that were
in high memory would use bounce buffers.  That way, a kmap_atomic() in
the ide-scsi interrupt handler wouldn't be necessary when doing PIO.

I have a patch to do that, but it modifies the files ide-scsi.c,
scsi_lib.c, and scsi_host.h.  Here it is in case my description wasn't
clear:

diff -purN a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-03-25 22:28:23.000000000 -0500
+++ b/drivers/scsi/ide-scsi.c	2005-03-31 15:17:38.000000000 -0500
@@ -1048,6 +1048,7 @@ static int idescsi_attach(ide_drive_t *d
 		return 1;
 
 	host->max_id = 1;
+	host->bounce_high = 1;
 
 #if IDESCSI_DEBUG_LOG
 	if (drive->id->last_lun)
diff -purN a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2005-03-25 22:28:21.000000000 -0500
+++ b/drivers/scsi/scsi_lib.c	2005-03-31 15:21:35.000000000 -0500
@@ -1344,6 +1344,9 @@ u64 scsi_calculate_bounce_limit(struct S
 	if (host_dev && host_dev->dma_mask)
 		bounce_limit = *host_dev->dma_mask;
 
+	if (shost->bounce_high && (bounce_limit > BLK_BOUNCE_HIGH))
+		return BLK_BOUNCE_HIGH;
+
 	return bounce_limit;
 }
 EXPORT_SYMBOL(scsi_calculate_bounce_limit);
diff -purN a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
--- a/include/scsi/scsi_host.h	2005-03-25 22:28:16.000000000 -0500
+++ b/include/scsi/scsi_host.h	2005-03-31 15:16:54.000000000 -0500
@@ -502,6 +502,12 @@ struct Scsi_Host {
 	unsigned reverse_ordering:1;
 
 	/*
+	 * Host needs all high memory bounced (useful for ide-scsi,
+	 * so it doesn't have to kmap when doing PIO)
+	 */
+	unsigned bounce_high:1;
+
+	/*
 	 * Host has rejected a command because it was busy.
 	 */
 	unsigned int host_blocked;

> 
>> patch, while this one is ide-scsi only, and Bart did accept it.  And,
>> to be honest, I wasn't really sure why the kmap_atomic() fix was
>> inferior. 
>> 
>> But I'd certainly defer to your (or Bart's) judgment on those
>> things-- you guys have a lot more experience than me with the
>> kernel.  I am hesitant to change the "ifdef"s to "if"s at this
>> point, since Bart already accepted it (previously) with the ifdefs,
>> but I'd be more than happy to change it if he agrees.
> 
> I agree ;-)
> 
> Cheers,
> Bartlomiej
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html  

