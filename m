From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Mon, 30 Apr 2007 01:36:28 +0900
Message-ID: <4634C98C.6040204@gmail.com>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <46348A8D.5070901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:20375 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbXD2Qgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 12:36:35 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1679623nzf
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 09:36:33 -0700 (PDT)
In-Reply-To: <46348A8D.5070901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> Anyways, can you try to hack it into ata_bmdma_error_handler()
> 
> From greping the code, I don't see how that function would ever
> be called from ata_piix.  ??

Yeah, I meant ata_bmdma_drive_eh().  You apparently have figured that
out already.  Sorry about the confusion.

-- 
tejun
