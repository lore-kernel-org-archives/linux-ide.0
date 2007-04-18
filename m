From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add Samsung HD401LJ to the NCQ blacklist
Date: Wed, 18 Apr 2007 16:56:51 +0900
Message-ID: <4625CF43.5010704@gmail.com>
References: <20070418061541.GA11293@roonstrasse.net> <4625BA1A.9030808@gmail.com> <20070418074859.GA21494@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:55093 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853AbXDRH45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 03:56:57 -0400
Received: by nz-out-0506.google.com with SMTP id s1so59036nze
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 00:56:56 -0700 (PDT)
In-Reply-To: <20070418074859.GA21494@roonstrasse.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Max Kellermann wrote:
> On 2007/04/18 08:26, Tejun Heo <htejun@gmail.com> wrote:
>> Can you try it on another controller?  Say, a ahci or sil24?
> 
> Seems to work ok on a Via VT8251 controller (AHCI) on kernel
> 2.6.21-rc6-git4 without my NCQ disabling patch.

Unfortunately, NCQ is not supported on VT8251, so it doesn't prove
anything.  :-(

> By the way, on this machine, I had a lot of SATA timeouts during
> kernel boot, which were solved by appending "nomsi".  Do you believe
> there might be a relation to the NCQ problems on my first (Nforce)
> machine?

It's more likely your chipset just has busted MSI support.  Please post
the result of 'lspci -tv' and 'lspci -nn'.

Thanks.

-- 
tejun
