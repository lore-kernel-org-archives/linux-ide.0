From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 9 Aug 2013 10:53:11 -0400
Message-ID: <20130809145311.GK20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
 <20130809140358.GA20515@mtj.dyndns.org>
 <5204FE63.4010903@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:40275 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704Ab3HIOxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:53:17 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so940371qap.7
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:53:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5204FE63.4010903@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

On Fri, Aug 09, 2013 at 06:36:19PM +0400, Sergei Shtylyov wrote:
> >Ummm... I'm sorry but I'm gonna do 180 from Sergei on this one.  The
> 
>    That's very unfortunate for me. :-(

Hehe, sorry. :)

> >So, please put the aux field into ata_taskfile.  That's where it
> >belongs.
> 
>    Can't agree to that. I was going to make 'struct ata_taskfile'
> reflect the historical notion and remove from it all not belonging
> to that notion. Alas, libata has a bad history of mistreating the
> historical terms...

But what does sticking to the historical definition give us when the
whole concept of TF is no longer maintained in new specs.  The
distinction between "command proper" and "supporting / plumbing
information" is still useful so I think it's natural to assign the
former to ata_taskfile and the latter to ata_queuedcmd.  After all,
there are cases where we want to describe command without all the
plumbing stuff libata imposes and given that the aux field is part of
FIS proper it might even get used for command results too in the
future.  I mean, FIS is the new TF.  We can rename ata_taskfile to
ata_fis and map things the other way but that'd just be extra churn.

Thanks.

-- 
tejun
