From: Tejun Heo <tj@kernel.org>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Mon, 15 Mar 2010 09:02:44 +0900
Message-ID: <4B9D7924.1020908@kernel.org>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com> <4B9881C8.10506@kernel.org> <4B9D0772.4080306@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33842 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab0COACu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Mar 2010 20:02:50 -0400
In-Reply-To: <4B9D0772.4080306@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

Hello,

On 03/15/2010 12:57 AM, Mark Lord wrote:
> No.  The vendor-unique commands appear to download a small firmware
> packet to the drive, which reprograms it for a longer "IDLE-3" timeout.
> 
> "IDLE-3" is what WD call this vendor-specific "powersaving" mode,
> and it is not intended to be adjustable.  Except via that little
> DOS utility hack, and even WD no longer make that available.
> 
> But I found it by googling for it, and it can change the timeout
> up to 30 seconds from the default of 8.  So I set my WD 1.5TB drive
> to use 30, and things are now acceptable.
> 
> Ugh (again)!

I'm currently talking with WD but in general I'm leaning toward simply
leaving it alone.  The manufacturer is actively preventing those
timesouts from being adjusted and they probably have a pretty good
rationale for that.  If those drives expire before their warrnty, it's
a matter between the customer and the vendor.  I really don't see much
point in trying to circumvent it.  Anyways, I'll let you guys know
where the conversation w/ WDC leads to.

Thanks.

-- 
tejun
