From: Stefan <gentoopower@yahoo.de>
Subject: Re: Kernel 2.6.6 Bug !!!!
Date: Mon, 10 May 2004 17:35:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409FA151.6070205@yahoo.de>
References: <409F64B7.6050906@yahoo.de> <409F9015.4020707@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:10145 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264645AbUEJP3D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 11:29:03 -0400
In-Reply-To: <409F9015.4020707@superbug.demon.co.uk>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

James Courtier-Dutton wrote:

> Stefan wrote:
>
>> Sorry for posting this to the ide list, but it is the only one I'm 
>> registered.
>>
>> I just got the new kernel 2.6.6. It seems like there is a really bad 
>> bug in it.
>> The Nvidia driver and my soundcard driver (this one I wrote myself), 
>> don't work anymore.
>>
>>
>> cmaudio.ko
>
>
> You say you wrote the soundcard driver yourself.
> Does alsa support your sound card. If not, I think the alsa project 
> would be very interested to look at your source code, so that they 
> could add support for it in alsa, and therefore the linux 2.6.x kernel 
> would have native support for it
>
> Just a thought.
>
> James
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
I already gave them my source code a couple of weeks ago, because their 
driver only featured 2 channel mode and had no volume control

My driver supports 2/4/6(5.1) channel and volume control. I think they 
have already commited some changes in cvs to their driver.
