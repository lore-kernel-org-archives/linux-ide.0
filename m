From: Yan Seiner <yan@seiner.com>
Subject: Re: Port multiplier resets
Date: Mon, 24 Nov 2008 20:44:07 -0800
Message-ID: <492B8297.3000303@seiner.com>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <4924D733.6070005@seiner.com> <4924D86C.8010107@kernel.org> <492837E0.3080906@seiner.com> <4928A97F.5040202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:58238 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbYKYEoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 23:44:08 -0500
In-Reply-To: <4928A97F.5040202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>
>
> The parameter isn't getting through.  Please make that work first.  Ask
> your distro how to do that and can you try a shorter cable?
>
>   

OK, that fixed it.  Turned out that with debian, you have to rebuild 
initrd to get the module parameters to work.

I've got everything limited to 1.5 Gbps, and the system is stable.  :-)

Thanks!

--Yan
