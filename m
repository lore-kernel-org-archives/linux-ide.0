From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [git patches] libata updates
Date: Tue, 01 May 2007 18:45:32 -0400
Message-ID: <4637C30C.5000109@seclark.us>
References: <20070429161542.GA12501@havoc.gtf.org> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us> <200705011438.07499.jesse.barnes@intel.com>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:45777
	"HELO smtpauth02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754760AbXEAWpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 18:45:33 -0400
In-Reply-To: <200705011438.07499.jesse.barnes@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jesse Barnes wrote:

>On Monday, April 30, 2007 1:22 pm Stephen Clark wrote:
>  
>
>>Please don't do this!
>>
>>Yeah the kernel will boot but the hd performance is sh*t on my
>>laptop. I am running FC6 with
>>kernel 2.6.21 and without the combined_mode setting my disk
>>performance goes down to a
>>whopping 1.25mb/sec from 44mb/sec when I boot with
>>combined_mode=libata. It make my
>>system unusable!
>>    
>>
>
>So your performance is good when you add combined_mode=libata?  I hope 
>so, because that's why I added it in the first place...
>
>However, Jeff's patch won't steal your performance as long as you make 
>sure you use the libata based drivers for everything.  If you're 
>running Fedora I think the rawhide kernels are configured this way, but 
>the fc6 era kernels aren't.
>
>Jesse
>
>  
>
I'm running fc6 but with kernel 2.6.21 from kernel.org - compiled with 
the .config file from fc6.

My system is a asus laptop with an ich7 chipset which has both sata and 
pata controllers. My
laptop only brings out the pata controller interface and both my hd and 
od are on the second
channel of the pata.

So can I configure out the old ide and just have ata_piix automatically 
control them both in
2.6.21?

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



