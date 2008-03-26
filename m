From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached
 if both IDENTIFYs are aborted
Date: Wed, 26 Mar 2008 23:43:52 +0900
Message-ID: <47EA6128.9000006@gmail.com>
References: <47E5F5D5.6050203@gmail.com> <47EA583C.8070501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:11188 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYCZOoI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2008 10:44:08 -0400
Received: by qb-out-0506.google.com with SMTP id e11so4491065qbe.15
        for <linux-ide@vger.kernel.org>; Wed, 26 Mar 2008 07:44:06 -0700 (PDT)
In-Reply-To: <47EA583C.8070501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Tejun Heo wrote:
> ..
>> Modify EH such that it assumes no device is attached if both flavors
>> of IDENTIFY are aborted by the device.  There really isn't much point
>> in retrying when the device actively aborts the commands.
> ..
> 
> And thus dies support for the few very early IDE drives that lacked
> IDENTIFY.
> 
> R.I.P.  :)
> 
> (not that they would have worked with libata in the first place)

How did they work anyway?  By specifying geometry manually to the
driver?  I think we can do that.  We just need another cute HORKAGE.
ATA_HORKAGE_NO_IDENITFY and some massaging around EH to handle it.
Heh... That's gonna be a silly but fun project.  :-)

-- 
tejun
