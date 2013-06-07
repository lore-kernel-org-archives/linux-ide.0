From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI bug: a lockup in ahci_interrupt with fbs enabled pmp
Date: Fri, 7 Jun 2013 15:56:39 -0700
Message-ID: <20130607225639.GH14781@mtj.dyndns.org>
References: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
 <20130606214748.GL5045@htj.dyndns.org>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085BAD21@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:38774 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3FGW4p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jun 2013 18:56:45 -0400
Received: by mail-qc0-f173.google.com with SMTP id l10so1217891qcy.18
        for <linux-ide@vger.kernel.org>; Fri, 07 Jun 2013 15:56:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085BAD21@SCYBEXDAG04.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Yu Liu <liuyu.ac@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, Jun 07, 2013 at 04:29:47AM +0000, Huang, Shane wrote:
> > Yeah, it's a bug.  ata_link_online() can't be called from interrupt
> > handlers.  Shane?  Can you please look into it?  What's the purpose
> > of ata_link_online() in ahci_error_intr()?
> 
> ata_link_online() was used to check that pmp link is active...
> which should be replaced by ata_link_active()?

ata_link_sactive() asks whether there are commands in progress.  I
don't think that fits in there.  Can't it just bounce to EH for actual
error handling?  Why is the link online check necessary?

Thanks.

-- 
tejun
