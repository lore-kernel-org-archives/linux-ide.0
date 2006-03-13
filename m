From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata crashes on incorrectly initialised ports
Date: Mon, 13 Mar 2006 05:09:11 -0500
Message-ID: <441544C7.3050406@garzik.org>
References: <44153810.10702@suse.de> <44153AAB.1000201@garzik.org> <441542C3.50205@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48103 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932333AbWCMKJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 05:09:13 -0500
In-Reply-To: <441542C3.50205@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

Hannes Reinecke wrote:
> Jeff Garzik wrote:
> 
>>Hannes Reinecke wrote:
>>
>>>Hi all,
>>>
>>>Randy found an interesting usage of the label 'err_out' in
>>>libata-core.c:ata_device_add().
>>>
>>>'err_out' is meant to be called to teardown existing sysfs entries.
>>>As such is it clearly wrong to call it if the sysfs registration fails.
>>>
>>>Please apply.
>>>
>>>Cheers,
>>>
>>>Hannes
>>>
>>>
>>>------------------------------------------------------------------------
>>>
>>>From: Hannes Reinecke <hare@suse.de>
>>>Subject: libata crashes on incorrectly initialized ports
>>>
>>>Randy Dunlap noted:
>>>With the update ahci I am getting these messages (typed by
>>>me, no serial port for console), but ata2 drive is not present (!?):
>>>
>>>ata2: could not start DMA engine
>>>BUG: unable to handle kernel NULL pointer dereference at virtual
>>>address 00000000
>>>
>>>plus a Call Trace like so (names only transcribed here):
>>>class_device_del
>>>class_device_unregister
>>>scsi_remove_host
>>>ata_host_remove
>>>ata_device_add
>>>ahci_init_one
>>>... normal pci driver init/register functions ...
>>>
>>>
>>>The label 'err_out' is used twice; the first usage of which is wrong
>>>as there is not host registered in sysfs which we could deregister.
>>>In fact, we haven't done anything (yet) so we might as well return
>>>here.
>>>
>>>Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>
>>>diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>>>index ab3257a..42e5c40 100644
>>>--- a/drivers/scsi/libata-core.c
>>>+++ b/drivers/scsi/libata-core.c
>>>@@ -4578,7 +4578,7 @@ int ata_device_add(const struct ata_prob
>>> 
>>>         ap = ata_host_add(ent, host_set, i);
>>>         if (!ap)
>>>-            goto err_out;
>>>+            return 0;
>>
>>NAK: This patch adds memory leaks.
>>
>>The clear intent of the error handling was to clean up host_set and the
>>ports allocated so far.  'return 0' just leaks all that stuff, rather
>>than performing the incorrect error handling ;-)
>>
> 
> Hmm. Okay.
> 
>>AFAICT, all the error handling at the err_out label is correct, save for
>>one detail:  do_unregister argument passed to ata_host_remove() should
>>be zero for the err_out callsite we are discussing.
>>
> 
> Not quite: ata_host_remove can _not_ be called with the first argument
> being NULL.
> 
> This leads to another interesting question:
> Do we allow for non-consecutive ports?
> Ie should it be possible for host_ent->port[1] to fail, but
> host_ent->port[2] to be present and useable?
> 
> The current code doesn't allow for that either; but if it's disallowed
> we can just tear down all ports after the first failed one.
> Which isn't handled currently, too :-)
> The current code will fail if not all ports found in host_ent->ports are
> useable. Which seems to be the case here.

Currently, that's intentional.  ata_host_add() failure indicates a 
serious error such as OOM or failure to get DMA memory, and as such 
everything should be torn down.

Most problems are not so serious, and fall into the category of "mark 
port disabled".  That "not so serious" category includes everything from 
malfunctioning hardware to ports disabled in BIOS to ports without 
attached devices.

So the current code already supports port[1] failing, but port[2] being 
usable.

	Jeff


