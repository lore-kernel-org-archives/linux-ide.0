From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Remove sync waiting code from libata
Date: Sat, 08 Sep 2007 19:36:30 +0200
Message-ID: <46E2DD9E.9080302@gmail.com>
References: <20070907024632.GH27404@parisc-linux.org> <46E259DD.5090609@gmail.com> <20070908171731.GB6809@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:38403 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbXIHRiM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:38:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so947141wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:38:10 -0700 (PDT)
In-Reply-To: <20070908171731.GB6809@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Sep 08, 2007 at 05:14:21PM +0900, Tejun Heo wrote:
>> Matthew Wilcox wrote:
>>> By using the scsi async probing code, we can remove the 'sync' argument
>>> from ata_scsi_scan_host():
>> Hmmm... How so?  @sync is there to keep device numbering stable even
>> when SCSI scan fails due to allocation failure.  I don't see how async
>> probing changes that.
> 
> async probing also keeps device numbering stable.  As long as the device
> responds within ten seconds (and the current code has half a second as
> the timeout), it'll get the same number it would have had, even though
> other hosts have successfully completed their probes during that time.

The @sync parameter is to work around GFP_ATOMIC allocation in SCSI scan
code.  A libata SCSI host can have upto 15 devices with PMP and with
multiple devices allocation failure is not so rare, probably because
libata SCSI scanning is done back-to-back in rapid succession.

The proper fix is probably to make SCSI scanning code not use GFP_ATOMIC
(there doesn't seem to be any reason to) but @sync is the bandaid till
that happens.

Thanks.

-- 
tejun
