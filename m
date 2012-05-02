From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v3)
Date: Wed, 2 May 2012 12:46:03 -0700
Message-ID: <20120502194603.GB6411@google.com>
References: <4FA043BE.2010009@teksavvy.com>
 <4FA04714.7050602@teksavvy.com>
 <20120501215854.GA21677@google.com>
 <4FA07655.6090506@teksavvy.com>
 <4FA07932.2090003@teksavvy.com>
 <4FA0A3F7.7000401@teksavvy.com>
 <20120502155414.GB21677@google.com>
 <4FA1898C.5070108@teksavvy.com>
 <20120502193343.GA6411@google.com>
 <4FA18E49.3040103@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37587 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab2EBTqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 15:46:09 -0400
Received: by pbbrp8 with SMTP id rp8so1512434pbb.19
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2012 12:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA18E49.3040103@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, May 02, 2012 at 03:43:05PM -0400, Mark Lord wrote:
> >> +static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
> > 
> > Return bool? && maybe split the patch into two - the first separating
> > out the logic into a function, the latter changing emedia handling?
> 
> I think the two-liner from v2 is better.

Heh, I don't know.  It probably doesn't matter all that much either
way.  Let's let Jeff decide. ;)

Thanks.

-- 
tejun
