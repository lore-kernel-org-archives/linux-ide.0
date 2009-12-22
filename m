From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Tue, 22 Dec 2009 09:06:50 +0900
Message-ID: <4B300D9A.3030804@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org> <4B14D454.7010300@kernel.org> <1259704924-sup-4007@utwig> <4B15C64E.7090106@kernel.org> <1259774491-sup-9212@utwig> <4B17042B.5070400@kernel.org> <4B17095C.50204@kernel.org> <1261167192-sup-3861@utwig> <4B2EFE87.6000206@kernel.org> <1261422681-sup-4043@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60583 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbZLVAFG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2009 19:05:06 -0500
In-Reply-To: <1261422681-sup-4043@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

Hello,

On 12/22/2009 04:13 AM, Alex Vandiver wrote:
> At Sun Dec 20 23:50:15 -0500 2009, Tejun Heo wrote:
>> Wow, that's unexpected.  Can you please post log of this with the
>> debugging patch applied?
> 
> I've only been able to replicate this once, and I didn't manage to
> save its dmesg, sadly.  I'll see if I can get it to crop up again,
> though.

Any failing trace witfffh long debounce timing would be helpful
because it really shouldn't be failing with long debounce timing.

Thanks.

-- 
tejun
