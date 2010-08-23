From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Mon, 23 Aug 2010 09:54:27 -0400
Message-ID: <4C727D93.4000105@teksavvy.com>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>	 <4C722FD4.2010305@kernel.org> <1282570893.30799.1.camel@corey> <4C727BFB.5070203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:28920 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751631Ab0HWNyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 09:54:24 -0400
In-Reply-To: <4C727BFB.5070203@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On 10-08-23 09:47 AM, Tejun Heo wrote:
> On 08/23/2010 03:41 PM, Mark Lord wrote:
>>> Don't we need this for other BMDMA commands too?  If so, maybe it's
>>> better to make it two patches?
>>
>>
>> TRIM is the first/only command which actually breaks
>> without this.  It is possible that other commands may
>> benefit as well on some DVD-RW drives, but I have not
>> encountered those yet.
>>
>> So for now, I've left it as a single patch,
>> with all of the (small) pieces together for TRIM.
>
> I see.  Looks good to me then.
>
> Acked-by: Tejun Heo<tj@kernel.org>
..

Peachy.  I do imagine that both of these patches
might also be prime candidates for -stable,
if/when they ever make it upstream.

Cheers
