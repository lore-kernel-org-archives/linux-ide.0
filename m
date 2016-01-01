From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v6 0/7] add support SATA for BMIPS_GENERIC
Date: Fri, 1 Jan 2016 11:34:22 +0900
Message-ID: <BE02ECD9-0E46-4D30-ACEC-D341F35315A5@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com> <56769896.6060908@ti.com> <2D90085B-23A9-4FE6-A203-5934749B4D04@gmail.com> <20151228155612.GQ5003@mtj.duckdns.org> <20160101022128.GC29040@htj.duckdns.org>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35980 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbcAACe1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Dec 2015 21:34:27 -0500
Received: by mail-pf0-f174.google.com with SMTP id 65so118118684pff.3
        for <linux-ide@vger.kernel.org>; Thu, 31 Dec 2015 18:34:27 -0800 (PST)
In-Reply-To: <20160101022128.GC29040@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

Hi Tejun,

> On Jan 1, 2016, at 11:21 AM, Tejun Heo <tj@kernel.org> wrote:
> 
> On Mon, Dec 28, 2015 at 10:56:12AM -0500, Tejun Heo wrote:
>> On Thu, Dec 24, 2015 at 09:52:52AM -0800, Florian Fainelli wrote:
>>> Thank you! Tejun, can you take the AHCI driver changes if they look good to you? Thanks!
>> 
>> Yeap, applied 1-4 to libata/for-4.5.
> 
> I messed up the order of the patches and applied 2-4 and then 1.  Can
> someone please verify that the following branch looks okay?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.5
> 

Looks good!

Thanks,
Jaedon

> Thanks.
> 
> -- 
> tejun

