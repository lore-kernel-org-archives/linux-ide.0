From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v3)
Date: Thu, 19 Mar 2009 09:23:35 +0900
Message-ID: <49C19087.5000307@gmail.com>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:28543 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZCSAXn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 20:23:43 -0400
Received: by ti-out-0910.google.com with SMTP id i7so147750tid.23
        for <linux-ide@vger.kernel.org>; Wed, 18 Mar 2009 17:23:40 -0700 (PDT)
In-Reply-To: <49C11ED4.2030307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> +            if (cnt && cnt <= max && (max & (max - 1)) == 0) {

Can you please include <linux/log2.h> and use is_power_of_2() instead?

Thanks.

-- 
tejun
