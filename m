From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 13 Nov 2007 12:08:34 +0900
Message-ID: <47391532.2000507@gmail.com>
References: <586940.45572.qm@web52611.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:9139 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbXKMDIt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 22:08:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1778827wah
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 19:08:48 -0800 (PST)
In-Reply-To: <586940.45572.qm@web52611.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org

Srihari Vijayaraghavan wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> [...] Please post boot log.
> 
> Both the working (with mem= option) & a panicking ones attached.
> 
> Actually as you've pointed out, it may have nothing to do with ahci or sb600
> as such, just that they helped in exposing the problem.
> 
> Because it started working with mem=3500M, I jumped to conclusions (as usual).

You need to turn on IOMMU.

-- 
tejun
