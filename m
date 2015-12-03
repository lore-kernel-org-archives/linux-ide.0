From: Tejun Heo <tj@kernel.org>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Thu, 3 Dec 2015 10:15:49 -0500
Message-ID: <20151203151549.GD27463@mtj.duckdns.org>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
 <20151201190410.GA21252@mtj.duckdns.org>
 <20151202093310.GE10207@awelinux>
 <20151202164753.GA19878@mtj.duckdns.org>
 <20151203093355.GF10207@awelinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34658 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbLCPPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2015 10:15:52 -0500
Content-Disposition: inline
In-Reply-To: <20151203093355.GF10207@awelinux>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>

Hello,

On Thu, Dec 03, 2015 at 10:33:55AM +0100, Andreas Werner wrote:
> All the other "flag" fields in the structs are used and/or reserved
> and it seems to be no good place for such flags.

You can use the port flags - ATA_FLAG_*.

> What I am thinking about is.
> 
> 1. Add new flag e.g. ATA_HORKAGE_NOLOG_PAGE_RD

ATA_FLAG_NO_LOG_PAGE?

Thanks.

-- 
tejun
