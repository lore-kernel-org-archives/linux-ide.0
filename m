From: Tejun Heo <tj@kernel.org>
Subject: Re: [v6 0/7] add support SATA for BMIPS_GENERIC
Date: Mon, 28 Dec 2015 10:56:12 -0500
Message-ID: <20151228155612.GQ5003@mtj.duckdns.org>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
 <56769896.6060908@ti.com>
 <2D90085B-23A9-4FE6-A203-5934749B4D04@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35572 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbL1P4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Dec 2015 10:56:14 -0500
Received: by mail-yk0-f182.google.com with SMTP id x67so105129877ykd.2
        for <linux-ide@vger.kernel.org>; Mon, 28 Dec 2015 07:56:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2D90085B-23A9-4FE6-A203-5934749B4D04@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Thu, Dec 24, 2015 at 09:52:52AM -0800, Florian Fainelli wrote:
> Thank you! Tejun, can you take the AHCI driver changes if they look good to you? Thanks!

Yeap, applied 1-4 to libata/for-4.5.

Thanks.

-- 
tejun
