From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v3)
Date: Thu, 19 Mar 2009 09:25:21 +0900
Message-ID: <49C190F1.7010202@kernel.org>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52849 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbZCSA0B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 20:26:01 -0400
In-Reply-To: <49C19087.5000307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>> +            if (cnt && cnt <= max && (max & (max - 1)) == 0) {
> 
> Can you please include <linux/log2.h> and use is_power_of_2() instead?

Please note that is_power_of_2() also checks for zero so the whole
condition can be changed to

	if (is_power_of_2(cnt) && cnt <= max)

Thanks.

-- 
tejun
