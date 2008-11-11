From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/3] libata: beef up iterators
Date: Tue, 11 Nov 2008 03:18:57 -0500
Message-ID: <49193FF1.90708@garzik.org>
References: <490EDA75.5060703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32934 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755360AbYKKITB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:19:01 -0500
In-Reply-To: <490EDA75.5060703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Elias Oltmanns <eo@nebensachen.de>

Tejun Heo wrote:
> There currently are the following looping constructs.
> 
> * __ata_port_for_each_link() for all available links
> * ata_port_for_each_link() for edge links
> * ata_link_for_each_dev() for all devices
> * ata_link_for_each_dev_reverse() for all devices in reverse order
> 
> Now there's a need for looping construct which is similar to
> __ata_port_for_each_link() but iterates over PMP links before the host
> link.  Instead of adding another one with long name, do the following
> cleanup.
> 
> * Implement and export ata_link_next() and ata_dev_next() which take
>   @mode parameter and can be used to build custom loop.
> * Implement ata_for_each_link() and ata_for_each_dev() which take
>   looping mode explicitly.
> 
> The following iteration modes are implemented.
> 
> * ATA_LITER_EDGE		: loop over edge links
> * ATA_LITER_HOST_FIRST		: loop over all links, host link first
> * ATA_LITER_PMP_FIRST		: loop over all links, PMP links first
> 
> * ATA_DITER_ENABLED		: loop over enabled devices
> * ATA_DITER_ENABLED_REVERSE	: loop over enabled devices in reverse order
> * ATA_DITER_ALL			: loop over all devices
> * ATA_DITER_ALL_REVERSE		: loop over all devices in reverse order
> 
> This change removes exlicit device enabledness checks from many loops
> and makes it clear which ones are iterated over in which direction.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Comments added and retargeted for #upstream.
> 
> This patchset is on top of
> 
> #upstream-fixes (9ce8e3073d9cfd6f859c22a25441db41b85cbf6e)
> + [1] patches-which-fell-off-the-crack-during-maintainership-handover patchset
> + [2] mask-off-DET-when-restoring-SControl-for-detach
> 
> [1] http://thread.gmane.org/gmane.linux.ide/35783
> [2] http://article.gmane.org/gmane.linux.ide/35792

applied to newly created #upstream (on top of just-sent #upstream-fixes)


