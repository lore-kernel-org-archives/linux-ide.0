From: jnengland77 <jnengland77@gmail.com>
Subject: Re: pata_sis:sg_write errors
Date: Tue, 16 Jan 2007 16:04:54 -0700
Message-ID: <99cb77560701161504w141cdabfrff751e8f6efcd94e@mail.gmail.com>
References: <loom.20070115T195130-154@post.gmane.org>
	 <45AC3064.3070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:42047 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbXAPXE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 18:04:57 -0500
Received: by an-out-0708.google.com with SMTP id b33so1157173ana
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 15:04:56 -0800 (PST)
In-Reply-To: <45AC3064.3070504@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi
Thank you for your help.  So all I need to do is update the sg3_utils?
 It's the only package I can find dealing with sg and scsi? And do I
have to set this parameter or is it automatically set?  I've never
dealt with this scsi system, because all I have are pata disks.  No
sata nor scsi.

> This is not a kernel bug.  The SCSI midlayer is bitching that grip
> hasn't set certain parameter while using the sg interface (which
> previous kernels have ignored).  grip should be updated to use proper
> parameter.  So, no, 2.6.20-rcX won't fix it.  You need to update grip.
>
> --
> tejun
>

~Jordan Neumeyer
