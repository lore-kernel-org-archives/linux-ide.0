From: Thomas Jackowski <aXe@hadiko.de>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Mon, 22 Jun 2009 20:40:21 +0200
Message-ID: <4A3FD015.4090602@hadiko.de>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org> <4A36FC7D.5050805@hadiko.de> <4A388E1F.5070404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:38934 "EHLO
	smtp1.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbZFVSkU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 14:40:20 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2])
	by jordan.hadiko.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <aXe@hadiko.de>)
	id 1MIoRK-0000ox-9I
	for linux-ide@vger.kernel.org; Mon, 22 Jun 2009 20:40:22 +0200
In-Reply-To: <4A388E1F.5070404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have no clue where this command comes from. How can I determine this?

I'm not using disk head parking.

Tejun Heo wrote:
> Hello,
> 
> Thomas Jackowski wrote:
>> I'm using 2.6.29-2-amd64 now and the bug still exists (see previous
>> mails) with AHCI and NCQ enabled.
>>
>> Maybe I should contact Seagate Support now?
>>
>> I wonder that nobody else reported this sort of problem?
> 
> There were several reports drives timing out some SMART commansd but
> on CPM I think yours is the only one.  BTW, where is that command
> coming from?  Are you using disk head parking?
> 
> Thanks.
> 

Thanks Thomas
