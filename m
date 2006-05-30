From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/12] libata-hp-prep: implement followup softreset handling
Date: Tue, 30 May 2006 00:12:28 -0400
Message-ID: <447BC62C.9080706@pobox.com>
References: <11488839582516-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52451 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751473AbWE3EMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:12:37 -0400
In-Reply-To: <11488839582516-git-send-email-htejun@gmail.com>
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


