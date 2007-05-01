From: Stefan <gentoopower@yahoo.de>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv
Date: Tue, 01 May 2007 02:19:42 +0200
Message-ID: <4636879E.1030201@yahoo.de>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56678 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946207AbXEAATy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 20:19:54 -0400
In-Reply-To: <4635BF4A.3050509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Tejun Heo wrote:
> Stefan wrote:
>   
>> Hi folks,
>>
>> yesterday I upgraded  kernel 2.6.19 to 2.6.20 (gentoo kernel). Now my
>> box locks up about 10 min after boot.
>> After that I tested with a vanilla 2.6.21.1 it shows the same behavior.
>> I'm attaching a kern log file from the 2.6.20. The 2.6.21.1 locked up so
>> hard, that there was no trace left in the log file.
>> If I switch back to 2.6.19 everything is fine again.
>> If necessary I will hook up a laptop to this box, so I can capture
>> messages via netconsole.
>>     
>
> Yes please.
>
>   
>> This machine is running an AMD X2 64, NFORCE4 (ASUS A8N-E)
>>
>> I haven't been following the development of libata for a while, but from
>> the 2.6.20 changelog It looks like there have been some major changes.
>>
>> Just let me know what kind of information you need in order to narrow it
>> down.
>>     
>
> Does giving 'sata_nv.adma=0' kernel parameter make any difference?
>
>   
It seems like switching off adma works. I didn't experience any problems
within the last few hours.
Just to mention I also use windows 2003 on this box with NCQ enabled (I
think the nvidia driver there states that ncq is active).

Should I recompile the kernel with some debugging options enabled?


