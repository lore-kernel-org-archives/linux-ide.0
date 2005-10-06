From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: Thu, 06 Oct 2005 16:04:01 +0900
Message-ID: <4344CC61.8070609@gmail.com>
References: <20051004221450.18205.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:50093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbVJFHEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 03:04:09 -0400
Received: by wproxy.gmail.com with SMTP id i2so170340wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 00:04:09 -0700 (PDT)
In-Reply-To: <20051004221450.18205.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org


  Hello, there.

linux@horizon.com wrote:
> I'm trying to bring up a new AMD64 (uniprocessor) storage server with
> 3x Sil3132 PCIe SATA controllers running 6x Seagate 7200.8 drives.
> 
> Kernel 2.6.13.2 + 2.6.13-rc7-libata1.patch.bz2 + PPSkit-light
> 
> I'm having some problems with intermitted (every few days) crashes
> which lock up the drives.  The machine is not yet in service, so
> activity is pretty light, but I've been running zcav on a 6-way RAID-0
> partition to keep it busy.  (350 MB/sec sustained is fun.)
> 
> I have twice seen an assert fail that I didn't manage to wrote down.
> (The first time, I though it was something I had done, and the second,
> someone rebooted it before I got a chance.)
> 
> Both times, the keyboard was still operating and I could scroll back.
> This last time, it was locked up hard and I could only get what was
> on the screen.  Omitting the leading ffffffff from the kernel addresses,
> and modulo any transcription errors, what I saw was:
> 
> 802c1d50 do_unblank_screen+272
> 8012117e do_page_fault+1838
> 80133a9c call_console_drivers+76
> 801348c9 vprintk+601
> 80147739 autoremove_wake_function+9
> 8012ff23 wake_up_common+67
> 8010f22d error_exit+0
> 80340b3a ata_gen_fixed_sense+138
> 8034128a ata_scsi_qc_complete+106
> 8033ceaa ata_qc_complete+362
> 80342c15 sil24_interrupt+325
> 

  Oh.. this is because of missing tf_read callback which is called from 
ata_gen_fixed_sense().  I'll try to figure out what to do about it a bit 
later.  I gotta leave for english lessons now.  I'm already a bit late.

  However, your kernel hitting that path means that some drives are 
actually generating errors.  Let's see about that after get tf_read 
thing fixed.

  Damn. I'm really late. :-)

> I know there are more recent kernels and sata_sil24 code, but that's
> the most current pair I could figure out how to fit together.
> 
> Trying the instructions at http://kernel.org/git/ gives me:
> 
> $ cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> defaulting to local storage area
> 17:54:10 URL:http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
> progress: 2 objects, 926 bytes
> error: File ca442d313d86dc67e0a2e5d584b465bd382cbf5c (http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git/objects/ca/442d313d86dc67e0a2e5d584b465bd382cbf5c) corrupt
> 
> Cannot obtain needed blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed
> cg-clone: pull failed
> 
> 
> In the mean time, I'll keep working to reproduce the problem.
> 
> Thanks for any hints!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
tejun
