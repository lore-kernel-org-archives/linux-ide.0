From: Elias Oltmanns <eo@nebensachen.de>
Subject: Current qc_defer implementation may lead to infinite recursion
Date: Sun, 10 Feb 2008 18:54:19 +0100
Message-ID: <87ir0w4rzo.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:57490 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbYBJSv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Feb 2008 13:51:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

due to your commit 31cc23b34913bc173680bdc87af79e551bf8cc0d libata now
sets max_host_blocked and max_device_blocked to 1 for all devices it
manages. Under certain conditions this may lead to system lockups due to
infinite recursion as I have explained to James on the scsi list (kept
you cc-ed). James told me that it was the business of libata to make
sure that such a recursion cannot happen.

In my discussion with James I imprudently claimed that this was easy to
fix in libata. However, after giving the matter some thought, I'm not at
all sure as to what exactly should be done about it. The easy bit is
that max_host_blocked and max_device_blocked should be left alone as
long as the low level driver does not provide the ->qc_defer() callback.
But even if the driver has defined this callback, ata_std_qc_defer() for
one will not prevent this recursion on a uniprocessor, whereas things
might work out well on an SMP system due to the lock fiddling in the
scsi midlayer.

As a conclusion, the current implementation makes it imperative to leave
max_host_blocked and max_device_blocked alone on a uniprocessor system.
For SMP systems the current implementation might just be fine but even
there it might just as well be a good idea to make the adjustment
depending on ->qc_defer != NULL.

Any ideas?

Regards,

Elias
