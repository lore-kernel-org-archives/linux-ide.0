From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 14/22] sata_sil24: update TF image only when necessary
Date: Sat, 13 May 2006 17:42:10 -0400
Message-ID: <446652B2.5080907@pobox.com>
References: <11473487912480-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46214 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932263AbWEMVmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 17:42:19 -0400
In-Reply-To: <11473487912480-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Update TF image (pp->tf) only when necessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 3 - 14.  Email on patches 1 and 2 (SCSI core patches) sent 
separatedly.


