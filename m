From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patch] hotplug fix patches added
Date: Mon, 12 Jun 2006 22:46:21 +0900
Message-ID: <448D702D.5010507@gmail.com>
References: <448B7FFD.9050507@gmail.com> <448C1C1E.7080109@pobox.com> <448C1FA7.6030305@gmail.com> <448D6F09.3080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:57055 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751956AbWFLNq1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 09:46:27 -0400
Received: by py-out-1112.google.com with SMTP id x31so1693947pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 06:46:27 -0700 (PDT)
In-Reply-To: <448D6F09.3080609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
>> Several drivers only need flags.  IMHO, having to allocate hpriv just 
>> for flags is a bit annoying.  I also thought about separating 
>> capability flags and dynamic flags but couldn't think of proper field 
>> name. ap->dyn_flags?  Also, it would be easy to screw up and test the 
>> wrong field.  Another sucky option was using u64 for flags.
> 
> I tend to think that most drivers fall into two categories:
> 
> * bmdma (PCI IDE-like) drivers
> * drivers which already do their own hpriv allocation and management
> 
> Therefore, I would be OK with adding a bmdma_flags member, to be used 
> only by bmdma drivers [and eventually separated from the high level 
> libata API, as discussed].  Otherwise, I would go ahead and add code to 
> allocate an hpriv structure in the driver.

Okay, bmdma_flags then.  I'll reserve lower 16 bits for generic bmdma 
flags and allow LLDDs to use upper 16 bits.

-- 
tejun
