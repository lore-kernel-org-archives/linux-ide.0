From: Stefan <gentoopower@yahoo.de>
Subject: Re: Kernel 2.6.6 Bug !!!!
Date: Mon, 10 May 2004 13:25:48 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409F66BC.1080708@yahoo.de>
References: <409F64B7.6050906@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:50254 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264634AbUEJLTF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 07:19:05 -0400
In-Reply-To: <409F64B7.6050906@yahoo.de>
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org

Stefan wrote:

> Sorry for posting this to the ide list, but it is the only one I'm 
> registered.
>
> I just got the new kernel 2.6.6. It seems like there is a really bad 
> bug in it.
> The Nvidia driver and my soundcard driver (this one I wrote myself), 
> don't work anymore.
>
> When I try to load those modules I get:
>
> Inavalid Module Format
>
> Who should I contact in order to resolve this issue immidiately????
>
> Tanks, R.S.
>
> P.S. On OSNews I saw someone mentioning:
>
>
> -mregparm=3 (register option) or 4 kb stacks
>
> both aren't set in my kernel
>
> Also I notived, both of the modules have a different name now in 2.6.5 
> they were named:
>
> cmaudio.ko
> nvidia.o
>
> now in 2.6.6
>
> cmaudio.o
> nvidia.ko
>
> Was there a change in compile flags or such thing?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Ah I just looked at the Makefile, there are a lot of changes in there, 
could it be that those changes break out of tree module compile?
Or do we have to make changes to the makefiles of our drivers?
