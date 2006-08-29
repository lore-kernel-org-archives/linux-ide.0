From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP... 'device	or	resource
 busy'
Date: Tue, 29 Aug 2006 23:57:06 +0900
Message-ID: <44F455C2.1010309@gmail.com>
References: <44E105A7.3030900@grokthis.net> <44E1C43E.1020302@gmail.com>	 <44E28313.7050601@grokthis.net>  <44F16750.5080100@gmail.com>	 <1156727790.28709.1.camel@lennon>  <44F3ACAB.5070506@gmail.com> <1156863511.3718.36.camel@manet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:32294 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965023AbWH2O6B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 10:58:01 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1306763nzf
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 07:58:01 -0700 (PDT)
In-Reply-To: <1156863511.3718.36.camel@manet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Windisch <eric@grokthis.net>
Cc: linux-ide@vger.kernel.org

Eric Windisch wrote:
>> The exclusive refs held above are never released.  Thus the kernel 
>> correctly denies any other exclusive access to the devices.  dm is 
>> holding them all.  I have never used dm so don't know much about it.  It 
>> seems that you'll have to make dm ignore those SCSI disks if you wanna 
>> use them for any other purpose.
> 
> I've never used it either, at least not directly.  Whatever it is doing
> is automatic.  However, you're right, I'm sorry for bringing up someone
> else's bug -- if nothing else, its good google fodder ;-)  So far, its
> looking to me like a bug in Ubuntu Dapper.

Maybe you're supposed to use all disks via dm, which actually makes 
sense.  Direct partitions on disks are pretty lame way to manage disks 
these days although I've never used anything else.  :-p

> I haven't yet figured out
> how to tell Ubuntu to leave my devices alone (yes, I looked at udev),
> but at least I can get my disks working!
> 
> $ dmsetup remove sde1
> root@san001:~# mkfs.ext3 -m1 /dev/sde1 2>/dev/null >/dev/null && echo 1
> 1

Great.

-- 
tejun
