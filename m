From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 09:39:30 -0400
Message-ID: <46261F92.2080607@seclark.us>
References: <88SeR-5Sf-15@gated-at.bofh.it>	<88Sov-662-3@gated-at.bofh.it>	<88SHV-6uL-29@gated-at.bofh.it>	<8agVk-3wc-81@gated-at.bofh.it>	<8b3IR-4mE-25@gated-at.bofh.it>	<8b3SA-4z3-5@gated-at.bofh.it>	<8b42g-51N-15@gated-at.bofh.it>	<8bbdm-7iS-27@gated-at.bofh.it>	<E1He8dA-0000mw-LI@be1.lrz>	<46260981.1040109@gmail.com>	<20070418132904.3322ba5f@the-village.bc.nu>	<46261337.3010406@gmail.com> <20070418140346.636879a1@the-village.bc.nu>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth05.prod.mesa1.secureserver.net ([64.202.165.99]:56713
	"HELO smtpauth05.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S2992475AbXDRNjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 09:39:32 -0400
In-Reply-To: <20070418140346.636879a1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Alan Cox wrote:

>>Thought about that and querying power state before doing shutdown 
>>sequence but things get somewhat ugly because shutdown sequence is 
>>driven from sd->shutdown().  We'll have to snoop both sync and shutdown 
>>commands and check whether the system is shutting down.  Also, I felt 
>>very uneasy about faking successful completion to SYNCHRONIZE_CACHE.
>>    
>>
>
>If you see a synchronize cache succeed and you then see the drive
>shutdown succeed then you know that a sync cache can be faked as ok
>safely. Any other command in between or after and it doesn't get faked
>
>This seems pretty easy to deal with at command issue.
>
>  
>
>>I dunno.  It's already too late for 2.6.21.  I was hoping we could get 
>>distros to update shutdown utilities in not-too-distant future but I 
>>have no experience with that.  Is that just a wishful thinking?
>>    
>>
>
>Probably not, but it will take a year or so and throughout this time
>period everyone with the wrong combination of shutdown and kernel (which
>will be a lot of people who compile their own kernels) are going to have
>problems caused by what is a very obscure piece of libata internal
>behaviour they'll never even know about.
>
>  
>
So this is the pop I hear on my new laptop that is using 
libata=combined_mode
 when I shut my system down. I didn't get the pop with the same disk 
drive in an older
 laptop that was only ide. It sounds like a relay closing or opening, 
but is really my
drive head doing an emergency retract/park?

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



