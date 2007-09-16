From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: Spurious completions during NCQ
Date: Sun, 16 Sep 2007 14:47:25 +0200
Message-ID: <46ED25DD.605@gmail.com>
References: <20070915005751.353d0c69.akpm@linux-foundation.org> <46EC7159.6000904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:55862 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbXIQI0u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 04:26:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1245058rvb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 01:26:49 -0700 (PDT)
In-Reply-To: <46EC7159.6000904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Sumanth J.V" <sumanth@cse.unl.edu>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
>>
>> Begin forwarded message:
>>
>> Date: Fri, 07 Sep 2007 12:57:14 -0500
>> From: "Sumanth J.V" <sumanth@cse.unl.edu>
>> To: linux-kernel@vger.kernel.org
>> Subject: Spurious completions during NCQ
>>
>>
>> I keep seeing this message a few times a day on my box.
>>
>> ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
>> ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18
>> FIS=004040a1:00000004)

Please report the result of "hdparm -I /dev/sda".

-- 
tejun

