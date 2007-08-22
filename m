From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 12:03:41 +0900
Message-ID: <46CBA78D.2070405@gmail.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:47365 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbXHVDDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 23:03:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so29049rvb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 20:03:46 -0700 (PDT)
In-Reply-To: <98147300-A282-4909-A393-079365833BD8@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

Rusty Conover wrote:
> Hi Tejun,
> 
> Just as some further testing and poking I added the drives to the list
> of disks to disable NCQ for, it didn't resolve the issue.
> 
> I increased the PMP timeout to 1000 rather then 250 and that didn't
> resolve the problem either.
> 
> The interface still has timeout errors writing the ext3 fs.

Can you just put one harddisk into one of the PMP slots and test it?
Does it still suffer timeouts?

-- 
tejun
