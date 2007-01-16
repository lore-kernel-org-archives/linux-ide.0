From: Tejun Heo <htejun@gmail.com>
Subject: Re: pata_sis:sg_write errors
Date: Tue, 16 Jan 2007 10:54:44 +0900
Message-ID: <45AC3064.3070504@gmail.com>
References: <loom.20070115T195130-154@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:31293 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbXAPByw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 20:54:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1531281uga
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 17:54:51 -0800 (PST)
In-Reply-To: <loom.20070115T195130-154@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Neumeyer <jnengland77@gmail.com>
Cc: linux-ide@vger.kernel.org

Jordan Neumeyer wrote:
> Well recently I've been using libata since my my distribution offered it when
> they switched to 2.6.19( maybe? 18) in the initramfs image.  I have a sis 5513
> controller, which after a couple of days started acting up and coming up with
> the following error:
> 
> sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing data i$;
>  program grip not setting count and/or reply_len properly
> printk: 319 messages suppressed.
> sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing data $n;
>  program grip not setting count and/or reply_len properly
> printk: 321 messages suppressed.
> sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
>  program grip not setting count and/or reply_len properly
> printk: 323 messages suppressed.
> sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
>  program grip not setting count and/or reply_len properly
> printk: 323 messages suppressed.
> sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
>  program grip not setting count and/or reply_len properly
> printk: 324 messages suppressed.
> 
> It's repeated over, and over; differing amounts of bytes.  I'm unsure what
> invoked such errors, because it only started to happen a few days after use of
> the kernel.  Which was 2.6.19-beyond kernel.  I don't believe any additions made
> by the beyond kernel affected the libata system.
> 
> Has this been fixed in the 2.6.20-rcXs?  

This is not a kernel bug.  The SCSI midlayer is bitching that grip
hasn't set certain parameter while using the sg interface (which
previous kernels have ignored).  grip should be updated to use proper
parameter.  So, no, 2.6.20-rcX won't fix it.  You need to update grip.

-- 
tejun
