From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Sat, 19 Jan 2008 17:05:37 -0500
Message-ID: <47927431.6030009@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
 <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca>
 <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca>
 <47871F88.8070109@gmail.com> <4787F82C.80709@shaw.ca>
 <47899D39.4050108@gmail.com> <478A6017.5060509@shaw.ca>
 <478AAE44.2000003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:39342 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbYATDMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 22:12:37 -0500
Received: from pd3mr1so.prod.shaw.ca
 (pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUX009RFA90FJA0@l-daemon> for linux-ide@vger.kernel.org; Sat,
 19 Jan 2008 20:12:36 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
 by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUX00KJIA90NB00@pd3mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Sat, 19 Jan 2008 20:12:37 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JUX005S8A8VR200@l-daemon> for linux-ide@vger.kernel.org; Sat,
 19 Jan 2008 20:12:35 -0700 (MST)
In-reply-to: <478AAE44.2000003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Tejun,

I've got the hardware fixed and everything is working great. I have two
PMP's attached to the system both with 4 drives and have had no problems.

Thanks


Tejun Heo wrote:
> Andrew Ryder wrote:
>   
>> Tejun,
>>
>> I have completed some of the testing, things were working fine.. then
>> something died. It will not even recognize the 4726 anymore. During book
>> when the HBA does it scan nor in windows 2000 does anything work or be
>> recognized.
>>
>> I will have a new eSATA cable this week sometime, maybe a pin got
>> shmucked if lucky. I've attached the logs of the good and the gone dead.
>>     
>
> Ah... definitely looks like a hardware problem.  Hopefully cable is the
> culprit.  I wish the warranty of your port multiplier hasn't expired yet.
>
>   

