From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh copy result_tf flags from outgoing tf
Date: Thu, 24 Apr 2008 11:43:18 +0900
Message-ID: <480FF3C6.2060705@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FB4AF.2060907@gmail.com> <480FC82F.8080404@rtr.ca> <480FDC0D.60302@gmail.com> <480FEF69.8000407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:17687 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbYDXCnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 22:43:24 -0400
Received: by py-out-1112.google.com with SMTP id u52so4688737pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 19:43:23 -0700 (PDT)
In-Reply-To: <480FEF69.8000407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>> Those flags are to tell which parts of the TF are valid or should be 
>> read in case of TFLAG_LBA48.  So, a TF after tf_read should always 
>> have TFLAG_ISADDR and TFLAG_DEVICE.  TFLAG_LBA48 works both ways.  If 
>> it was set when tf_read is called the higher part of LBA is read and 
>> the resulting tf should have TFLAG_LBA48 set.  But yeah the original 
>> code isn't like that.  If you can fix it up together with the NCQ 
>> path, it would be great.
> ..
> 
> No, I'm not going to touch the mainline path.  tf_read is used to read
> the taskfile, but it doesn't always contain an LBA address, so I'm not so
> sure that forcing TFLAG_ISADDR is always correct.
> 
> And since I don't know that code as well as you, I don't want to end up
> having to help debug something that might break as a result.
> 
> This may warrant two patches.. one to fix the NCQ bug (already posted),
> and perhaps another from you or Jeff if you want to change the behaviour.

Alright, fair enough.

-- 
tejun
