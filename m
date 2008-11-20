From: Yan Seiner <yan@seiner.com>
Subject: Re: Port multiplier resets
Date: Wed, 19 Nov 2008 19:19:15 -0800
Message-ID: <4924D733.6070005@seiner.com>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:46929 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbYKTDTQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 22:19:16 -0500
In-Reply-To: <49194B20.8000209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>
> 2. Specify libata.force=8.15:1.5Gbps
>   
dumb question:

Does this go on the kernel parameter line or can I change it without 
rebooting the system?

I don't see it in /sys/module/libata/parameters so I'm guessing it needs 
a reboot?

--Yan
