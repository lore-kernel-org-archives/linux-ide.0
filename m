From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/22] libata: implement qc->result_tf
Date: Thu, 18 May 2006 16:22:06 +0900
Message-ID: <446C209E.7060907@gmail.com>
References: <11473487911193-git-send-email-htejun@gmail.com> <446C1DE5.5080000@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:56131 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWERHWO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 03:22:14 -0400
Received: by wx-out-0102.google.com with SMTP id s6so301297wxc
        for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 00:22:13 -0700 (PDT)
In-Reply-To: <446C1DE5.5080000@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> Normally 0x50 is seen with normal completion, not 0x40.

I'm okay either way.  One of my drives reports 0x40 for normal status, 
so it's where 0x40 came from.

> Do we really have to fake qc->result_tf here? Maybe just keep it zero or garbage
> is good enough: if err_mask == 0 and ATA_QCFLAG_RESULT_TF is not set, qc->result_tf
> shouldn't be used anyway.

Hmmm... Right.  I thought libata SCSI completion path checks TF status 
unconditionally and added the code.  Maybe I was confused.  I cannot 
find the offending part now.  Hmmm... I seem to recollect I met a 
spurious error due to garbage inside qc->result_tf and added the code to 
initialize it.  I'll keep looking.

-- 
tejun
