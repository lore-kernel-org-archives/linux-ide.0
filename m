From: Tejun Heo <tj@kernel.org>
Subject: Re: ata link not reset properly
Date: Wed, 23 Jun 2010 19:31:46 +0200
Message-ID: <4C224502.2040206@kernel.org>
References: <4C223F8A.9030306@odi.ch> <4C224429.6010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59979 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab0FWRbv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2010 13:31:51 -0400
In-Reply-To: <4C224429.6010705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 06/23/2010 07:28 PM, Tejun Heo wrote:
> Maybe we can use hardreset as the last resort before ditching the
> device.  Something like the following.  Can you please try it and post
> the kernel log?  Thanks.

Meh, it won't work.  It's failing softreset so we should be checking
reset try counts.  I'll try to write up something tomorrow.

Thanks.

-- 
tejun
