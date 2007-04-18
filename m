From: Tejun Heo <htejun@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 21:50:35 +0900
Message-ID: <4626141B.7090703@gmail.com>
References: <88SeR-5Sf-15@gated-at.bofh.it>	<88Sov-662-3@gated-at.bofh.it>	<88SHV-6uL-29@gated-at.bofh.it>	<8agVk-3wc-81@gated-at.bofh.it>	<8b3IR-4mE-25@gated-at.bofh.it>	<8b3SA-4z3-5@gated-at.bofh.it>	<8b42g-51N-15@gated-at.bofh.it>	<8bbdm-7iS-27@gated-at.bofh.it>	<E1He8dA-0000mw-LI@be1.lrz>	<46260981.1040109@gmail.com> <20070418132904.3322ba5f@the-village.bc.nu> <46261337.3010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:3246 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422975AbXDRMun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 08:50:43 -0400
Received: by wr-out-0506.google.com with SMTP id 76so130566wra
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 05:50:42 -0700 (PDT)
In-Reply-To: <46261337.3010406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Tejun Heo wrote:
> Alan Cox wrote:
>>> Not that simple.  Most disks don't spin up on SYNCHRONIZE_CACHE if 
>>> its cache is clean.  Sadly some disks actually spin up when it 
>>> receives spin down command while spun down to immediately spin down 
>>> again, so we would be fixing problem for some number of disks while 
>>> breaking others.  :-(
>>
>> Snoop the last command sent to the drive, that tells you if you can skip
>> the cache flush ?
> 
> Thought about that and querying power state before doing shutdown 
> sequence but things get somewhat ugly because shutdown sequence is 
> driven from sd->shutdown().  We'll have to snoop both sync and shutdown 
> commands and check whether the system is shutting down.  Also, I felt 
> very uneasy about faking successful completion to SYNCHRONIZE_CACHE.
> 
> I dunno.  It's already too late for 2.6.21.  I was hoping we could get 
> distros to update shutdown utilities in not-too-distant future but I 
> have no experience with that.  Is that just a wishful thinking?
> 

FWIW, the the following message describes the proposed solution.

http://thread.gmane.org/gmane.linux.scsi/30487/focus=17392

-- 
tejun
