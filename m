From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [git patches] libata updates
Date: Mon, 30 Apr 2007 16:22:18 -0400
Message-ID: <46364FFA.9050500@seclark.us>
References: <20070429161542.GA12501@havoc.gtf.org> <46364901.4000907@redhat.com> <46364C04.4050208@garzik.org>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]:55008
	"HELO smtpout10.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1946766AbXD3UWW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 16:22:22 -0400
In-Reply-To: <46364C04.4050208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:

>Chuck Ebbert wrote:
>  
>
>>Jeff Garzik wrote:
>>    
>>
>>>Jeff Garzik (8):
>>>      libata/IDE: remove combined mode quirk
>>>      
>>>
>>You can't just remove the "combined_mode=" kernel parameter or
>>every Linux user who uses that will get an unbootable kernel
>>with no good way of diagnosing the problem. It should still
>>be accepted and just print a warning.
>>    
>>
>
>No, most modern distros will simply Just Work(tm) due to mount by label, 
>udev, and similar gadgets.
>
>As long as you have at least one (if not both) ATA drivers, you have a 
>kernel that will boot your hardware.  And by definition those using 
>combined_mode= do indeed have the necessary drivers.
>
>	Jeff
>
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
Please don't do this!

Yeah the kernel will boot but the hd performance is sh*t on my laptop. I 
am running FC6 with
kernel 2.6.21 and without the combined_mode setting my disk performance 
goes down to a
whopping 1.25mb/sec from 44mb/sec when I boot with combined_mode=libata. 
It make my
system unusable!

Regards,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



