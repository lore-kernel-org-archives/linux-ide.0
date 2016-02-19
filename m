From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH libata/for-4.6] libata: fix unbalanced
 spin_lock_irqsave/spin_unlock_irq() in ata_scsi_park_show()
Date: Fri, 19 Feb 2016 11:01:48 -0500
Message-ID: <20160219160148.GJ13177@mtj.duckdns.org>
References: <20160217192435.GA14960@mwanda>
 <20160218165418.GE13177@mtj.duckdns.org>
 <87ziuxgpnu.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33966 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423897AbcBSQBu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Feb 2016 11:01:50 -0500
Received: by mail-yw0-f172.google.com with SMTP id h129so70858024ywb.1
        for <linux-ide@vger.kernel.org>; Fri, 19 Feb 2016 08:01:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87ziuxgpnu.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-ide@vger.kernel.org

On Fri, Feb 19, 2016 at 07:49:57AM +0100, Elias Oltmanns wrote:
> On 18 February 2016 at 17:54 CET, Tejun Heo wrote:
> >> From 3948b6f2b7677165324afe52c3bd0088ca7c776c Mon Sep 17 00:00:00 2001
> > From: Tejun Heo <tj@kernel.org>
> > Date: Thu, 18 Feb 2016 11:50:37 -0500
> > 
> > ata_scsi_park_show() was pairing spin_lock_irqsave() with
> > spin_unlock_irq().  As the function is always called with irq enabled,
> > it didn't actually break anything.  Use spin_lock_irq() instead.
> 
> Thanks for taking care of this. As I stated earlier, I'd suggest exactly
> the same change for ata_scsc_park_store() too, though.

Send a patch?

-- 
tejun
