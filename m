From: Mark Lord <kernel@teksavvy.com>
Subject: Re: ata_eh_link_autopsy:  Bug?
Date: Tue, 01 May 2012 19:48:37 -0400
Message-ID: <4FA07655.6090506@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:31703 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab2EAXsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2012 19:48:38 -0400
In-Reply-To: <20120501215854.GA21677@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-05-01 05:58 PM, Tejun Heo wrote:
> On Tue, May 01, 2012 at 04:27:00PM -0400, Mark Lord wrote:
>> MMmm.. even that isn't good enough, because the first ATA_QCFLAG_IO test
>> bypasses the rest of that logic and triggers unconditional retries.  Ugh.
> 
> Hmmm... the unconditional retry on ATA_QCFLAG_IO is intenttional so
> that known good requests from FS are guaranteed to be retried no
> matter how whacky the underlying device is.  I'm not sure whether that
> was a good decision tho.  Maybe we should trust the hardware a bit
> more.  So, I'm not necessarily against changing it.

With multi-terabyte drives being commonplace now, bad sectors seem
to be a more frequent occurrence than I can remember from the past.

And when libata stumbles across a bad sector, it literally hangs the
machine for _minutes_ doing retries.  I have never seen a retry make
any difference whatsoever on a bad sector read.  New, old, or ancient hardware.

Cheers
