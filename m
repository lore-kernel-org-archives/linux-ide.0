From: Tejun Heo <tj@kernel.org>
Subject: Re: libata's awful reaction to passworded disks
Date: Thu, 19 Jun 2014 10:01:37 -0400
Message-ID: <20140619140137.GK11042@htj.dyndns.org>
References: <508686.83315.qm@web100003.mail.kks.yahoo.co.jp>
 <20140619113807.401e21ea@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:63292 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbaFSOBk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2014 10:01:40 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so2210942qcy.15
        for <linux-ide@vger.kernel.org>; Thu, 19 Jun 2014 07:01:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140619113807.401e21ea@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Norman Diamond <n0diamond@yahoo.co.jp>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, Jun 19, 2014 at 11:38:07AM +0100, One Thousand Gnomes wrote:
> On Thu, 19 Jun 2014 13:18:34 +0900 (JST)
> Norman Diamond <n0diamond@yahoo.co.jp> wrote:
> 
> > If someone has set a password on an ATA/SATA hard drive and someone later connects the drive to a Linux system (before or after booting that Linux system), libata reacts in an unbearably stupid manner.
> 
> Yes. It's well known. Send patches if you care. So far nobody has cared
> enough to write the code to use the key rings to deal with drive
> unlocking.

Hmmm... the reads are prolly from the partition code but I wonder why
libata is not classifying it as AC_ERR_DEV.  ie. why isn't
ata_eh_link_autopsy() delivering just the ATA_EH_REVALIDATE verdict?
Another thing to be updated is ata_eh_worth_retry() so that it returns
false for IO commands if the device is locked.  Or maybe
ata_eh_link_autopsy() can set AC_ERR_INVALID for this case.  Yeah,
that'd make more sense.  Anyways, it should be relatively straight
forward.

Does anyone want to give a crack at it?

-- 
tejun
