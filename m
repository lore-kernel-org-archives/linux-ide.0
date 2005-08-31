From: Tyler <pml@dtbb.net>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Wed, 31 Aug 2005 11:31:35 -0700
Message-ID: <4315F787.3030003@dtbb.net>
References: <VA.0000198c.018c7ed4@foxhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tor.primus.ca ([216.254.136.21]:61147 "EHLO
	smtp-01.primus.ca") by vger.kernel.org with ESMTP id S932363AbVHaSbk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Aug 2005 14:31:40 -0400
Received: from [216.86.99.21] (helo=[192.168.0.28])
	by smtp-01.primus.ca with esmtpa (Exim 4.50)
	id 1EAXMz-0003rJ-54
	for linux-ide@vger.kernel.org; Wed, 31 Aug 2005 14:31:33 -0400
In-Reply-To: <VA.0000198c.018c7ed4@foxhill.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

First thing you can try Ian, is a vanilla kernel, to rule out ubuntu's 
custom kernel.  I would suggest trying the vanilla kernel, and the -mm tree.

Tyler.

Ian Oliver wrote:

>In article <17173.49068.154562.170503@Psilocybe.Update.UU.SE>, Thorild 
>Selen wrote:
>  
>
>>In that case, it could be that the problem only appears on SMP/HT
>>systems, which would be interesting to know.
>>    
>>
>
>I have the problem (maybe!) with a TX2plus/PDC20375 on kernel 2.6.10 
>(Ubuntu Hoary) on an Ahtlon system (so no HT or SMP)
>
>See http://bugzilla.ubuntu.com/show_bug.cgi?id=13046
>
>Regards
>
>Ian
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>
