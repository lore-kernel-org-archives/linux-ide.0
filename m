From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Sun, 09 Jul 2006 01:56:12 +0900
Message-ID: <44AFE3AC.9030709@gmail.com>
References: <44AD749C.1070208@rtr.ca> <44AD76CA.40100@pobox.com> <44AD77D5.90905@rtr.ca> <200607061724.13448.liml@rtr.ca> <44AD8A25.7020006@pobox.com> <44AE5BA1.6000409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:46324 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964889AbWGHQzU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 12:55:20 -0400
Received: by nz-out-0102.google.com with SMTP id z3so1187885nzf
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 09:55:19 -0700 (PDT)
In-Reply-To: <44AE5BA1.6000409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Ric Wheeler <ric@emc.com>

Hello, Mark Lord.

Mark Lord wrote:
[--snip--]
> I dunno what the new EH does (yet), but the only good way to deal with this
> is for the ATA status & error values to be read *and* saved on command 
> completion,
> and then reused by any later code that needs to do detailed sense reporting
> or other diagnostics.

Yeap, this is exactly what new EH does.  It stores TF in qc->result_tf 
on failure and EH/SCSI completion only uses the cached TF stored at the 
time of failure.

> With NCQ/TCQ, this can be tough to achieve, possibly requiring the LLDD 
> to drop to legacy mode on error, and capture the values there.  Of 
> course, by then
> it's too late to be perfect, as the host controller has probably already 
> read
> and discarded the drive status at least once.  (the PDC sata_qstor device
> is an exception there -- they save/return failed status during queuing).

With NCQ, the true TF is retrieved via log page 10.  EH retrieves it and 
stores it in qc->result_tf.  The rest is the same.

With PMP, things get more interesting though.  :-(

-- 
tejun
