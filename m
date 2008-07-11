From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Fri, 11 Jul 2008 23:20:04 +0200
Message-ID: <200807112320.04264.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <200807072000.26380.bzolnier@gmail.com> <48732EF5.6080302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:27119 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYGJVZF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 17:25:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1725167ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 14:24:59 -0700 (PDT)
In-Reply-To: <48732EF5.6080302@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

On Tuesday 08 July 2008, Sergei Shtylyov wrote:

[...]

> >>>Index: b/drivers/ide/ide-iops.c
> >>>===================================================================
> >>>--- a/drivers/ide/ide-iops.c
> >>>+++ b/drivers/ide/ide-iops.c
> >>>@@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
> >>> 	 */
> >>> 
> >>> 	SELECT_MASK(drive, 1);
> >>>-	if (IDE_CONTROL_REG)
> >>>-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
> >>>+	ide_set_irq(drive, 1);
> 
> >>    If we're going to execute the command using polling, isn't it logical to 
> >>*disable* drive's interrupt instead of enabling it which this code is 
> >>currently doing?  This looks like it might work only for the drivers having 
> >>the maskproc() method (of which hpt366.c is the only one that I've ever dealt 
> >>with).
> 
> > Yes, this needs fixing.
> 
>     But should we honor drive->quirk_list here? What its different values 
> mean? I'm seeing either 1 or 2 is used to decide whether to set nIEN or not...

I did some research on ->quirk_list in the past but I couldn't exactly
figure it out.  I also wasn't able to trace this code to its author
(not that I tried very hard)...

Anyway my current findings/theories are the following:

- the diff between hpt366 and pdc202xx_{new,old} quirky devices:

--- hpt366.c    2008-04-12 22:03:54.000000000 +0200
+++ pdc202xx_new.c      2008-04-12 22:04:03.000000000 +0200
@@ -1,7 +1,11 @@
-static const char *quirk_drives[] = {
+static const char *pdc_quirk_drives[] = {
        "QUANTUM FIREBALLlct08 08",
        "QUANTUM FIREBALLP KA6.4",
+       "QUANTUM FIREBALLP KA9.1",
        "QUANTUM FIREBALLP LM20.4",
+       "QUANTUM FIREBALLP KX13.6",
+       "QUANTUM FIREBALLP KX20.5",
+       "QUANTUM FIREBALLP KX27.3",
        "QUANTUM FIREBALLP LM20.5",
        NULL
 };

  indicates that pdc202xx_{new,old} lists lack few devices that were added
  only to hpt366 and need fixing

- different values 1 (used by hpt366) or 2 (used by pdc202xx_new) are used
  stricly for historical reasons (IOW they are the result of people hitting
  problems with nIEN in different places and lack of generic solution) so
  we should make ->quirk_list a single bit flag and enable all quirks for
  both host drivers

- the problem most likely is not limited to hpt366/pdc202xx_{new,old}
  so we should move its handling to core IDE code

- we should make sure that all SELECT_MASK() users also call ide_set_irq()
  (then sgiioc4's ->maskproc can be removed since it is a copy of ->set_irq)

- we may want to make SELECT_MASK() call enable/disable_irq() for
  ->quirk_list device if there is no >maskproc method

- we need to be a bit careful with hpt366's ->maskproc because it checks
  for ->quirk_list internally (so either we need to mask/unmask for all
  devices on hpt366 or limit masking/unmasking to ->quirk_list on icside)

- we should merge SELECT_MASK() with ide_set_irq() and consider skipping
  ide_set_irq() for ->quirk_list devices


There is an added bonus in fixing the above issues as it would result in
(finally) having sane API for IRQ (un)masking, namely:

* ->set_irq in struct ide_tp_ops for device's side

* ->maskproc in struct ide_port_ops for controller's side


As usual, I'll be glad to help with any patches.

Thanks,
Bart
