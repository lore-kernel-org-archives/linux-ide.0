From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [git patches] libata updates
Date: Tue, 01 May 2007 07:55:34 -0400
Message-ID: <46372AB6.7000902@seclark.us>
References: <20070429161542.GA12501@havoc.gtf.org> <46364901.4000907@redhat.com> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us> <46365234.6010804@garzik.org>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:59872
	"HELO smtpauth02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031673AbXEALzg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 07:55:36 -0400
In-Reply-To: <46365234.6010804@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:

>Stephen Clark wrote:
>  
>
>>Yeah the kernel will boot but the hd performance is sh*t on my laptop. I 
>>am running FC6 with
>>kernel 2.6.21 and without the combined_mode setting my disk performance 
>>goes down to a
>>whopping 1.25mb/sec from 44mb/sec when I boot with combined_mode=libata. 
>>It make my
>>system unusable!
>>    
>>
>
>
>No, that's the split-driver configuration that causes the slowdown.
>
>Now that both drivers fully support the hardware, either driver can make 
>things go full speed.
>
>Please try testing the update first :)
>
>	Jeff
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Ok, I'am willing to test it out, but how to I get a patch file from the 
git stuff?

I currently have the 2.6.21 kernel source.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



