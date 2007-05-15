From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [PATCH] libata: track spindown status and skip spindown_compat
 if possible
Date: Tue, 15 May 2007 08:12:29 -0400
Message-ID: <4649A3AD.8070108@seclark.us>
References: <46498B82.1030802@gmail.com> <loom.20070515T133840-438@post.gmane.org> <4649A180.1050100@gmail.com>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:47132
	"HELO smtpout05.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1756413AbXEOMMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 08:12:31 -0400
In-Reply-To: <4649A180.1050100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Francesco Pretto <ceztko@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:

>Francesco Pretto wrote:
>  
>
>>Tejun Heo <htejun <at> gmail.com> writes:
>>    
>>
>>>Our assumption that most distros issue STANDBYNOW seems wrong.  The
>>>upstream sysvinit and thus many distros including gentoo and opensuse
>>>don't take any action for libata disks on spindown.  We can skip
>>>compat handling for these distros so that they don't need to update
>>>anything to take advantage of kernel-side shutdown.
>>>
>>>      
>>>
>>Working around the workaround won't make confusion? Won't this break again
>>implementations that was actually issuing STANDBYNOW, assuming that they
>>actually exist? Only wondering, can't say for any init implementation in
>>particular.
>>    
>>
>
>Yeah, it's a big mess.  With this patch applied, what happens is...
>
>* If your shutdown(8) does issue STANDBYNOW : you get the big fat
>warning and kernel won't issue STANDBYNOW.
>
>* If your shutdown(8) doesn't issue STANDBYNOW : kernel issues FLUSH
>CACHE followed by STANDBYNOW and all is well and dandy without any
>userland modification.
>
>I think it isn't too bad.  Any better ideas?
>
>  
>
Ok, I am running fc6 with kernel.org 2.6.21 what do I need to do to keep 
my laptop from
popping, and having my retract_count increment, every time I shutdown?

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



