From: Tejun Heo <tj@kernel.org>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 11 Mar 2010 14:53:52 +0900
Message-ID: <4B988570.4040005@kernel.org>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com> <4B9881C8.10506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36373 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab0CKFx4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 00:53:56 -0500
In-Reply-To: <4B9881C8.10506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

On 03/11/2010 02:38 PM, Tejun Heo wrote:
> Heh, yeah, that's pretty low.  I hope they eventually learn to adjust
> that dynamically considering running avg of intervals between writes.
> It shouldn't be too hard.

or just bump load cycle limit by x10 or x100.  :-P

storage-fixup can't be the permanent solution.  The only reason I
created it was because I thought it was a passing phase and the
blacklist wouldn't keep growing.

In both reports here, the avg load cycle frequency seems to be about 1
per 2 minutes.  With 300k cycle rating (drives often happily go over
it), it means 1.14 year of continuous operation, which depending on
usage pattern might be considered acceptable.  Maybe the right thing
to do is to simply let it be and if it expires before within the
warranty period, get it RMA'd.

Hmmm... or, we can make a utility which monitors smart output, detects
unload cycle and periodically poll load status and issue a bogus read
whenever the disk unloads its heads so that we can storm the vendors
with RMAs.  :-)

Coming back to the reality, I'll ask vendors about it and see whether
we need to keep worrying about it or we can just let it be.

Thanks.

-- 
tejun
