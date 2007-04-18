From: Tejun Heo <htejun@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 21:05:21 +0900
Message-ID: <46260981.1040109@gmail.com>
References: <88SeR-5Sf-15@gated-at.bofh.it> <88Sov-662-3@gated-at.bofh.it> <88SHV-6uL-29@gated-at.bofh.it> <8agVk-3wc-81@gated-at.bofh.it> <8b3IR-4mE-25@gated-at.bofh.it> <8b3SA-4z3-5@gated-at.bofh.it> <8b42g-51N-15@gated-at.bofh.it> <8bbdm-7iS-27@gated-at.bofh.it> <E1He8dA-0000mw-LI@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:28800 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422910AbXDRMF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 08:05:27 -0400
Received: by nz-out-0506.google.com with SMTP id s1so104507nze
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 05:05:27 -0700 (PDT)
In-Reply-To: <E1He8dA-0000mw-LI@be1.lrz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Bodo Eggert wrote:
>> SCSI part of the fix is queued in scsi-misc-2.6 tree and libata-dev part
>> is acked and waiting to be merged, so the fix will be available in
>> 2.6.22.  However, it's disabled by default to remain compatible with the
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> current behavior and requires userland change to fully fix the problem.
>   ^^^^^^^^^^^^^^^^
> It sounds like the Schilling kind of compatibility: "The old burner destroyed
> your disk on buffer underruns, therefore the new thing should do the same
> instead of giving you a perfectly readable data disk."
> 
> Guys, not destroying hardware is _NOT_ bad!

Not that simple.  Most disks don't spin up on SYNCHRONIZE_CACHE if its 
cache is clean.  Sadly some disks actually spin up when it receives spin 
down command while spun down to immediately spin down again, so we would 
be fixing problem for some number of disks while breaking others.  :-(

-- 
tejun
