From: Tejun Heo <htejun@gmail.com>
Subject: Re: pata_sis:sg_write errors
Date: Wed, 17 Jan 2007 11:14:29 +0900
Message-ID: <45AD8685.4080903@gmail.com>
References: <loom.20070115T195130-154@post.gmane.org>	 <45AC3064.3070504@gmail.com> <99cb77560701161504w141cdabfrff751e8f6efcd94e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:15556 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXAQCOn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 21:14:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1864632uga
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 18:14:42 -0800 (PST)
In-Reply-To: <99cb77560701161504w141cdabfrff751e8f6efcd94e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jnengland77 <jnengland77@gmail.com>
Cc: linux-ide@vger.kernel.org

jnengland77 wrote:
> Hi
> Thank you for your help.  So all I need to do is update the sg3_utils?
> It's the only package I can find dealing with sg and scsi? And do I
> have to set this parameter or is it automatically set?  I've never
> dealt with this scsi system, because all I have are pata disks.  No
> sata nor scsi.

You need to update grip, cd ripper.  And, it's not something a user can
change.  The program itself needs to be updated.  So, bug the grip
developers.  The messages are just notices to let people know that those
programs need to be updated and can be safely ignored for the time being.

-- 
tejun
