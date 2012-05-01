From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_eh_link_autopsy:  Bug?
Date: Tue, 1 May 2012 14:58:54 -0700
Message-ID: <20120501215854.GA21677@google.com>
References: <4FA043BE.2010009@teksavvy.com>
 <4FA04714.7050602@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:38780 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab2EAV7B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2012 17:59:01 -0400
Received: by gghe5 with SMTP id e5so65391ggh.19
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2012 14:58:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA04714.7050602@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, May 01, 2012 at 04:27:00PM -0400, Mark Lord wrote:
> MMmm.. even that isn't good enough, because the first ATA_QCFLAG_IO test
> bypasses the rest of that logic and triggers unconditional retries.  Ugh.

Hmmm... the unconditional retry on ATA_QCFLAG_IO is intenttional so
that known good requests from FS are guaranteed to be retried no
matter how whacky the underlying device is.  I'm not sure whether that
was a good decision tho.  Maybe we should trust the hardware a bit
more.  So, I'm not necessarily against changing it.

Thanks.

-- 
tejun
