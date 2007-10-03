From: Tejun Heo <htejun@gmail.com>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Wed, 03 Oct 2007 12:30:08 +0900
Message-ID: <47030CC0.8040601@gmail.com>
References: <20071002170445.GB2902@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:9173 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbXJCDbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 23:31:41 -0400
Received: by an-out-0708.google.com with SMTP id d31so658605and
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 20:31:41 -0700 (PDT)
In-Reply-To: <20071002170445.GB2902@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-ide@vger.kernel.org

Marc MERLIN wrote:
> Howdy,
> 
> I've had a system with 2.6.22.1 for a while, running 10 drives
> behind a PMP on a sil24 card with no problems.
> 
> Recently, I swapped 5 250GB drives with 5 TB drives.
> The 5 TB drives eventually get detected, but do not work reliably.

1. Does booting with fewer number of drives (say 5) help?

2. Does limiting PHY speed to 1.5Gbps using DIP switch on the harddrive
help?

-- 
tejun
