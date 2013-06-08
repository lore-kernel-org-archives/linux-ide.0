From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI bug: a lockup in ahci_interrupt with fbs enabled pmp
Date: Fri, 7 Jun 2013 23:01:25 -0700
Message-ID: <20130608060125.GA12758@mtj.dyndns.org>
References: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
 <20130606214748.GL5045@htj.dyndns.org>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085BAD21@SCYBEXDAG04.amd.com>
 <20130607225639.GH14781@mtj.dyndns.org>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085BB1FA@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56338 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3FHGB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jun 2013 02:01:29 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so5439750pbc.25
        for <linux-ide@vger.kernel.org>; Fri, 07 Jun 2013 23:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085BB1FA@SCYBEXDAG04.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Yu Liu <liuyu.ac@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Sat, Jun 08, 2013 at 05:59:27AM +0000, Huang, Shane wrote:
> > ata_link_sactive() asks whether there are commands in progress.  I
> > don't think that fits in there.  Can't it just bounce to EH for actual
> > error handling?  Why is the link online check necessary?
> 
> I tried hard to recall why I put ata_link_online() check there, at
> last I find it was suggested by you in 2009 when you reviewed v2 :-)
> 
> http://marc.info/?l=linux-ide&m=125170571525422&w=2

Heh, so it's my own stupidity. :)

> Need I submit a patch to remove online check or you will handle it?

It'd be great if you can submit a patch.

Thanks a lot!

-- 
tejun
