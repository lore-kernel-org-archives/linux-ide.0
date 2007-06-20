From: Mark Lord <liml@rtr.ca>
Subject: Hard lockup with ata_piix 2.6.21.1: strange traceback, too
Date: Wed, 20 Jun 2007 17:12:13 -0400
Message-ID: <4679982D.2030000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4619 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbXFTVMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 17:12:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi guys,

I'm debugging a system here based on ICH7/ata_piix.
When we hot-pull a drive, it locks up solid.
That's fine, but I'd like to find/fix the lockup.

So as part of poking around, I rebuilt the kernel with frame pointers,
and inserted a WARN_ON(1) into ata_busy_sleep() to see who was calling it
just before things locked up. 

Here's the result:  http://rtr.ca/libata.png

Can anyone here make sense of that traceback??
Are we *really* recursing inside the EH code?

Thanks
