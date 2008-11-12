From: Tejun Heo <htejun@gmail.com>
Subject: Re: WD3200BEVT frequent head unload
Date: Wed, 12 Nov 2008 14:30:19 +0900
Message-ID: <491A69EB.80507@gmail.com>
References: <39e8b4be0811031614s2c28352ao62a7e937bbf90cc3@mail.gmail.com> <4910825B.8020103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:43885 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYKLFa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 00:30:26 -0500
Received: by ti-out-0910.google.com with SMTP id b6so121855tic.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Nov 2008 21:30:24 -0800 (PST)
In-Reply-To: <4910825B.8020103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Aleksei Kazantsev <ajk.xyz@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Aleksei Kazantsev wrote:
>> drive unloads the head up to 360 times per hour
> ..
> 
>> *    Advanced Power Management feature set
> ..
> 
> Presumably "hdparm -B255 /dev/sda" cures this ?

Please verify hdparm -B255 or 254 fixes the problem.

Thanks.

-- 
tejun
