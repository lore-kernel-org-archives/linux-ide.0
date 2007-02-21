From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Wed, 21 Feb 2007 22:19:27 +0900
Message-ID: <45DC46DF.8030704@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>	 <45D574B1.8080109@tw.ibm.com>	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>	 <45D58270.4080909@tw.ibm.com>	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>	 <45DAD8DA.4000108@gmail.com>	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>	 <45DBEB63.3010905@gmail.com> <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:15495 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161213AbXBUNTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 08:19:30 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2338276wxd
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 05:19:29 -0800 (PST)
In-Reply-To: <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

Patrick Ale wrote:
> On 2/21/07, Tejun Heo <htejun@gmail.com> wrote:
> 
>>
>> That's normal but your drives are failing classification.  Can you
>> please apply the attached patch and report what the kernel says.  You
>> can turn off DEBUG options.
> 
> Hi,
> 
> The patch fails on both 2.6.20 and the linus-upstream source.
> patching file drivers/ata/libata-core.c
> Hunk #1 FAILED at 716.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/ata/libata-core.c.rej
> 
> I see only two lines have to be added, can I do this manualy?

Sure.  Thanks.

-- 
tejun
