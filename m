From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH libata/for-4.6] libata: fix unbalanced spin_lock_irqsave/spin_unlock_irq() in ata_scsi_park_show()
Date: Fri, 19 Feb 2016 07:49:57 +0100
Message-ID: <87ziuxgpnu.fsf@denkblock.local>
References: <20160217192435.GA14960@mwanda>
	<20160218165418.GE13177@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.nebensachen.de ([5.45.99.250]:53318 "EHLO
	mail.nebensachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161212AbcBSGuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Feb 2016 01:50:01 -0500
In-Reply-To: <20160218165418.GE13177@mtj.duckdns.org> (Tejun Heo's message of
	"Thu, 18 Feb 2016 11:54:18 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-ide@vger.kernel.org

On 18 February 2016 at 17:54 CET, Tejun Heo wrote:
>> From 3948b6f2b7677165324afe52c3bd0088ca7c776c Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Thu, 18 Feb 2016 11:50:37 -0500
> 
> ata_scsi_park_show() was pairing spin_lock_irqsave() with
> spin_unlock_irq().  As the function is always called with irq enabled,
> it didn't actually break anything.  Use spin_lock_irq() instead.

Thanks for taking care of this. As I stated earlier, I'd suggest exactly
the same change for ata_scsc_park_store() too, though.

Regards,

Elias
