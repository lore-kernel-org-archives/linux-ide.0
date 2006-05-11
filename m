From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Thu, 11 May 2006 17:31:35 +0900
Message-ID: <4462F667.3060504@gmail.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:36671 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030190AbWEKIbl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 04:31:41 -0400
Received: by py-out-1112.google.com with SMTP id f28so163225pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 01:31:40 -0700 (PDT)
In-Reply-To: <1147334740.7273.38.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Tejun
> 
> We just tested your git tree on thinkpad T43P laptop, and found that
> after ata_piix resumed from S3, SATA disk can't be read/write anymore.
> But according to the test result of kernel 2.6.16-rc6 on T43P, ata_piix
> can resume from S3 successfully.
> 
> We know that this problem may be not related to your patches, but I
> think you know the libata development status very well, maybe you can
> give us some clue about what happened to ata_piix between 2.6.16-rc6 and
> your git tree.
> 

Hello, Zhao.

I haven't really followed AHCI suspend/resume stuff but AFAICT it never
made to #upstream.  I don't know whether it was included in -rc# or not.
 But it sounds like it did.

One thing to note about suspend/resume is they should be handled from
EH.  IIRC, they weren't synchronized properly with the rest of libata.
Maybe it can be another ATA_EH action or maybe it needs separate
handling but at any rate it should be handled as part of EH to be
synchronized properly.  I'm planning to work on suspend/resume once the
currently pending changes settle down.  I thought about including them
in this round but the changes were HUGE as they were, so decided to
defer it.

-- 
tejun
