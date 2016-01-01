From: Tejun Heo <tj@kernel.org>
Subject: Re: [v6 0/7] add support SATA for BMIPS_GENERIC
Date: Thu, 31 Dec 2015 21:21:28 -0500
Message-ID: <20160101022128.GC29040@htj.duckdns.org>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
 <56769896.6060908@ti.com>
 <2D90085B-23A9-4FE6-A203-5934749B4D04@gmail.com>
 <20151228155612.GQ5003@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35752 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcAACVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Dec 2015 21:21:31 -0500
Received: by mail-qg0-f42.google.com with SMTP id o11so210345049qge.2
        for <linux-ide@vger.kernel.org>; Thu, 31 Dec 2015 18:21:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151228155612.GQ5003@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Mon, Dec 28, 2015 at 10:56:12AM -0500, Tejun Heo wrote:
> On Thu, Dec 24, 2015 at 09:52:52AM -0800, Florian Fainelli wrote:
> > Thank you! Tejun, can you take the AHCI driver changes if they look good to you? Thanks!
> 
> Yeap, applied 1-4 to libata/for-4.5.

I messed up the order of the patches and applied 2-4 and then 1.  Can
someone please verify that the following branch looks okay?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.5

Thanks.

-- 
tejun
