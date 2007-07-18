From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 14:08:21 +0900
Message-ID: <469DA045.90706@gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>	 <469D8A99.8050102@gmail.com>	 <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>	 <469D93F3.8030707@gmail.com> <6b01c6170707172201gde9e437q714dea601916087d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:7844 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXGRFI1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 01:08:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1888rvb
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 22:08:26 -0700 (PDT)
In-Reply-To: <6b01c6170707172201gde9e437q714dea601916087d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: flyashi@gmail.com
Cc: linux-ide@vger.kernel.org

Yasha Okshtein wrote:
>> It defaults to softreset.
> 
> That still leaves the original problem of hardresets :)

Yeah, I know, but with all other things served well by SCSI scan
request, I don't really think another reset request mechanism is too
compelling.  After all, why do you care whether SRST or HRST is used?
It's a reset anyway.

-- 
tejun
