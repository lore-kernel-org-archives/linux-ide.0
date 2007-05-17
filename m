From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Thu, 17 May 2007 17:27:56 +0200
Message-ID: <464C747C.4060307@gmail.com>
References: <46492931.4080700@gentoo.org> <46496D47.9010504@gmail.com> <464BACD5.3030003@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:3820 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbXEQP2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 11:28:16 -0400
Received: by py-out-1112.google.com with SMTP id a29so874659pyi
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 08:28:15 -0700 (PDT)
In-Reply-To: <464BACD5.3030003@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-ide@vger.kernel.org

Hello,

Daniel Drake wrote:
> Am I right in saying, to fix 2.6.21, the following patches are needed,
> and no others, in this order:
> 
> sd: fix return value of sd_sync_cache()
> 3721050afc6cb6ddf6de0f782e2054ebcc225e9b
> (not sure if this one is required?)

It's a bug fix but not necessary for manage_start_stop.

> [SCSI] sd: implement START/STOP management
> 3c94c5a2fb43a654e777f509d5032b0db8ed09f

The commit is is missing the first 'c', so it's
c3c94c5a2fb43a654e777f509d5032b0db8ed09f.

> libata: reimplement suspend/resume support using sdev->manage_start_stop
> 9666f4009c22f6520ac3fb8a19c9e32ab973e828
> 
> libata: implement libata.spindown_compat
> 920a4b1038e442700a1cfac77ea7e20bd615a2c3
> 
> libata: fix shutdown warning message printing
> da071b42f73dabbd0daf7ea4c3ff157d53b00648
> 
> libata: track spindown status and skip spindown_compat if possible
> 13b8d09f5de0aaa3153bbccc98baf247387823dc

Now there's one more patch.

  http://article.gmane.org/gmane.linux.ide/18934

> Additionally, no userspace modifications are needed, at least while
> Gentoo's shutdown/halt programs are not attempting to spin down libata
> disks?

Yes.

> I note that the patch titled "SCSI: kill sht->suspend/resume" (not
> included in the above tree) is not yet merged into Linus' tree. Am I
> right in saying it's not required for the disk spindown stuff to work
> properly?

Yes, your right.  It's clean up of now unused feature and doesn't affect
any functionality.

One thing I'm worried about is reimplement-suspend-resume (9666f400).
It hasn't received testing in -mm and got merged into -rc, so it would
be a good idea to wait for a week or two and see whether any regression
is caused by the change before applying it to distro kernel.

Thanks.

-- 
tejun
