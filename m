From: Tejun Heo <htejun@gmail.com>
Subject: Re: cached PCS
Date: Thu, 10 Aug 2006 13:50:25 +0900
Message-ID: <44DABB11.5020707@gmail.com>
References: <44D97F07.9000301@garzik.org> <44D9AF83.80507@gmail.com> <44D9B43A.9010807@garzik.org> <44D9B4BC.5050707@gmail.com> <44D9B87A.8020507@garzik.org> <44D9BB4B.9050602@gmail.com> <44D9BD06.5080103@garzik.org> <44D9C31B.6000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:11663 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161023AbWHJEuc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 00:50:32 -0400
Received: by py-out-1112.google.com with SMTP id z74so662040pyg
        for <linux-ide@vger.kernel.org>; Wed, 09 Aug 2006 21:50:31 -0700 (PDT)
In-Reply-To: <44D9C31B.6000901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Keith Owens <kaos@ocs.com.au>, stevenm@umd.edu

Tejun Heo wrote:
>> Did you look at some of the other messages?  He provided some debug 
>> traces in follow-up messages.
> 
> Yes, I have and I can't think of any other way than ignoring PCS to work 
> around the problem.  If we set IGNORE_PCS for ich5 sata then we can also 
> forget about cached PCS which is for ich5 sata.  But, we might see ghost 
> device detection and accompanying long delays.
> 
> For ich 6/7/8, your recent change and honor-pcs patch should do the job. 
>  For ICH5, well...  Just set IGNORE_PCS and wait for bug reports?

[CC'ing Steve (the bug reporter of #6724), Hi!]

Steve just reported -rc4 doesn't fix the problem && he saw complete 
misdetection of *all* devices on soft reboots.  I think Steve and Keith 
are experiencing the same problem here.

PCS enabled bits are cleared at some point and cached PCS works around 
the problem by caching the bits early but for soft reboots it doesn't do 
any good.  One interesting thing is that BIOSen seem to recognize the 
drives fine (right?) on such reboots even though PCS enabled bits would 
be zero.  FWIW, IGNORE_PCS works fine for Steve.

Thanks.

-- 
tejun
