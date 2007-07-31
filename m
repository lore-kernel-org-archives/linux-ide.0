From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/4] Expose Power Management Policy option to users
Date: Tue, 31 Jul 2007 15:27:34 +0900
Message-ID: <46AED656.8070407@gmail.com>
References: <20070705194909.337398431@intel.com> <20070705130518.135e4e3c.kristen.c.accardi@intel.com> <46AE12B6.6090408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:32964 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXGaG1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 02:27:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so519691rvb
        for <linux-ide@vger.kernel.org>; Mon, 30 Jul 2007 23:27:48 -0700 (PDT)
In-Reply-To: <46AE12B6.6090408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, edwintorok@gmail.com, axboe@kernel.dk

Jeff Garzik wrote:
> Any chance the SCSI peeps could ACK this, and then let me include it in
> the ALPM patchset in the libata tree?

ATA link PS is pretty complex with HIPM, DIPM and AHCI ALPM.  I'm not
sure whether this three level knob would be sufficient.  It might be
good enough if we're gonna develop extensive in-kernel black/white list
specifying which method works on which combination but my gut tells me
that it's best left to userland (probably in the form of per-notebook PS
profile).

Adding to the fun, there are quite a few broken devices out there which
act weirdly when link PS actions are taken.

Also, I generally don't think AHCI ALPM is a good idea.  It doesn't have
'cool down' period before entering PS state which unnecessarily hampers
performance and might increase chance of device malfunction.

So, mild NACK from me.

-- 
tejun
