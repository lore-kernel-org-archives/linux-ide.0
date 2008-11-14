From: Mark Lord <liml@rtr.ca>
Subject: Re: WD3200BEVT frequent head unload
Date: Thu, 13 Nov 2008 21:34:31 -0500
Message-ID: <491CE3B7.6060201@rtr.ca>
References: <39e8b4be0811031614s2c28352ao62a7e937bbf90cc3@mail.gmail.com> <4910825B.8020103@rtr.ca> <491A69EB.80507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46147 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYKNCdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Nov 2008 21:33:43 -0500
In-Reply-To: <491A69EB.80507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Aleksei Kazantsev <ajk.xyz@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Please verify hdparm -B255 or 254 fixes the problem.

Aleksei Kazantsev wrote:
> Yes, after "hdparm -B255 /dev/sda" Load_Cycle_Count stopped increasing.


Need anything else?
