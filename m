From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [git patches] libata updates
Date: Tue, 01 May 2007 20:48:34 -0400
Message-ID: <4637DFE2.5020706@seclark.us>
References: <20070429161542.GA12501@havoc.gtf.org> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us> <200705011438.07499.jesse.barnes@intel.com> <4637C30C.5000109@seclark.us> <4637C3F4.5030800@redhat.com>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout06-04.prod.mesa1.secureserver.net ([64.202.165.227]:59633
	"HELO smtpout06.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2992614AbXEBAsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 20:48:38 -0400
In-Reply-To: <4637C3F4.5030800@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jesse Barnes <jesse.barnes@intel.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Chuck Ebbert wrote:

>Stephen Clark wrote:
>  
>
>>I'm running fc6 but with kernel 2.6.21 from kernel.org - compiled with
>>the .config file from fc6.
>>
>>My system is a asus laptop with an ich7 chipset which has both sata and
>>pata controllers. My
>>laptop only brings out the pata controller interface and both my hd and
>>od are on the second
>>channel of the pata.
>>
>>So can I configure out the old ide and just have ata_piix automatically
>>control them both in
>>2.6.21?
>>
>>    
>>
>
>Sure, just edit the .config. You may need to play with options to mkinitrd
>though; I don't think it will include the PATA drivers for you automatically.
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
It worked - no combined_mode=libata and my hd is doing 45mb/sec.
Thanks to all who replied.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



