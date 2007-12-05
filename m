From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Wed, 05 Dec 2007 10:43:33 +0900
Message-ID: <47560245.70306@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com> <002d01c83615$79261090$6539a8c0@usish.com.cn> <4754B995.4010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:40060 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXLEBnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:43:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6662008wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:43:41 -0800 (PST)
In-Reply-To: <4754B995.4010800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> sam song wrote:
> =>> Hmmm... It's timeout.  How long does the command take?  It's a bit weird
>>> because 36000s but the reported command duration is 136s.  How long did
>>> the command take actually?
>> The command did actually take 136minutes25seconds. I set the timeout in app
>> as 36000seconds(10-hour). 
> 
> Right, 136m.  I wonder whether it's hitting some hard timeout limit in
> the kernel.  Hmmmm... Does the attached patch fix your problem?

Ping.  Did it work?

-- 
tejun
