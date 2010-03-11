From: Tejun Heo <tj@kernel.org>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 11 Mar 2010 14:38:16 +0900
Message-ID: <4B9881C8.10506@kernel.org>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50665 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab0CKFiV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 00:38:21 -0500
In-Reply-To: <4B965DE7.7000109@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

Hello,

On 03/09/2010 11:40 PM, Mark Lord wrote:
> The default on these drives is to unload heads
> after a mere eight (8) seconds of inactivity.
> 
> Ugh.

Heh, yeah, that's pretty low.  I hope they eventually learn to adjust
that dynamically considering running avg of intervals between writes.
It shouldn't be too hard.

> The wdidle3-1.03 DOS tool can fix that.  Google it.
> 
> I have disassembled that tool here, and found a few
> vendor-unique commands inside it.  But thus far have
> not managed to get them working natively in Linux.
> 
> I really need a SATA tracer/analyser..

Hmmm... so they don't respond to ATA APM command?

Thanks.

-- 
tejun
