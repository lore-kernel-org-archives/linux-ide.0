From: Tejun Heo <htejun@gmail.com>
Subject: Re: WD3200BEVT frequent head unload
Date: Mon, 17 Nov 2008 12:41:29 +0900
Message-ID: <4920E7E9.4040202@gmail.com>
References: <39e8b4be0811031614s2c28352ao62a7e937bbf90cc3@mail.gmail.com> <4910825B.8020103@rtr.ca> <491A69EB.80507@gmail.com> <491CE3B7.6060201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:5230 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYKQDlg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 22:41:36 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1389660tic.23
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 19:41:34 -0800 (PST)
In-Reply-To: <491CE3B7.6060201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Aleksei Kazantsev <ajk.xyz@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Please verify hdparm -B255 or 254 fixes the problem.
> 
> Aleksei Kazantsev wrote:
>> Yes, after "hdparm -B255 /dev/sda" Load_Cycle_Count stopped increasing.
> 
> 
> Need anything else?

added.  I used 254 as other BEVT was happy with it.

Thanks.

-- 
tejun
