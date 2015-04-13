From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add an additional LPM policy to match Intel
 recommendations
Date: Mon, 13 Apr 2015 13:56:21 -0400
Message-ID: <20150413175621.GI2596@htj.duckdns.org>
References: <1428696929-2988-1-git-send-email-mjg59@coreos.com>
 <20150413143225.GB2596@htj.duckdns.org>
 <CAPeXnHsgxDn3qzdru2SKhaO=J66vA3pSoPr=eHFfasaWeHCMNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34473 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbDMR4Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2015 13:56:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPeXnHsgxDn3qzdru2SKhaO=J66vA3pSoPr=eHFfasaWeHCMNg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Matthew Garrett <mjg59@coreos.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Mon, Apr 13, 2015 at 10:52:59AM -0700, Matthew Garrett wrote:
> Ok - my only real concern there was that we might end up changing the
> semantics of medium_power enough that it would break somebody. I'll
> post a patch to do that instead and I guess we can see what happens -
> worst case we revert it and add a new one.

Yeah, that sounds like a good plan to me.

Thanks.

-- 
tejun
