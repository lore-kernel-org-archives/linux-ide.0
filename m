From: Tejun Heo <tj@kernel.org>
Subject: Re: Port multiplier resets
Date: Thu, 20 Nov 2008 12:24:28 +0900
Message-ID: <4924D86C.8010107@kernel.org>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <4924D733.6070005@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbYKTDYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 22:24:33 -0500
In-Reply-To: <4924D733.6070005@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> Tejun Heo wrote:
>>
>> 2. Specify libata.force=8.15:1.5Gbps
>>   
> dumb question:
> 
> Does this go on the kernel parameter line or can I change it without
> rebooting the system?
> 
> I don't see it in /sys/module/libata/parameters so I'm guessing it needs
> a reboot?

Yeah, you will need to reboot or reload libata module.  Note that if
libata.ko is being loaded from initrd, different distros use different
methods to pass parameters to them.

-- 
tejun
