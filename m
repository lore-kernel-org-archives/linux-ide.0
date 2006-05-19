From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 14/14] libata-hp-prep: implement followup softreset handling
Date: Fri, 19 May 2006 11:21:25 -0400
Message-ID: <446DE275.6050005@pobox.com>
References: <11480445851340-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932346AbWESPVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:21:34 -0400
In-Reply-To: <11480445851340-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> In some cases, hardreset must be followed by SRST.
> 
> * some controllers can't classify with hardreset
> * some controllers can't wait for !BSY after hardreset (LLDD should
>   explicitly request followup softreset by returning -EAGAIN)
> * (later) PM needs SRST w/ PMP==15 to operate after hardreset
> 
> To handle above cases, this patch implements follow-up softreset.
> After a hardreset, ata_eh_reset() checks whether any of above
> conditions are met and do a follow-up softreset if necessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


