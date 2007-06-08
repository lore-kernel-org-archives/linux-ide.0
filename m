From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 08 Jun 2007 23:12:01 +0900
Message-ID: <466963B1.4070208@gmail.com>
References: <20070604235157.GD31462@havoc.gtf.org> <20070608114119.GE29122@htj.dyndns.org> <20070608135517.GA24346@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:24260 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968175AbXFHOMI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 10:12:08 -0400
Received: by nz-out-0506.google.com with SMTP id n1so745132nzf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 07:12:08 -0700 (PDT)
In-Reply-To: <20070608135517.GA24346@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> On Fri, Jun 08, 2007 at 08:41:19PM +0900, Tejun Heo wrote:
>> libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
>> ports too.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> This has been this way as long as I can remember.  It's almost
>> pleasant to see that it survived through all the devres/init rework.
>> I guess it's time for a change.
> 
> pci_request_regions() should claims everything, if Alan did his job :)
> 
> All this goes through ata_pci_init_one(), which guarantees it's PCI IDE.

Allowing legacy to be used on non-PCI systems was your idea!  Alright,
then we can drop a lot of junk from legacy SFF code.  Will prep another
patch.  Please ignore two patches in this thread.

-- 
tejun
