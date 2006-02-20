From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: implement and use ata_dev_revalidate()
Date: Mon, 20 Feb 2006 05:48:47 -0500
Message-ID: <43F99E8F.6000408@pobox.com>
References: <11399977652752-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12754 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964865AbWBTKsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:48:51 -0500
In-Reply-To: <11399977652752-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.  Hello, Albert.
> 
> This patchset is the fourth and last part of divided 'reorganize
> configuration and implement revalidation' patchset[1].  The third part
> was posted about half an hour ago[2].
> 
> This patchset is against
>   the current upstream (254a5c45f8e53775a1e1dd7498a8dcd665341f1e)
>   + rename ata_dev_id_[c_]string() patch [3]
>   + reorganize ata_dev_identify() patchset [2]
> 
> Note: Jeff, I generated patches over the rename patch as the patch
>       make naming not only shorter but also more consistent.  If you
>       don't like the rename, I'll regenerate this patchset without it.
> 
> This patchset implements ata_dev_revalidate() and use it after
> configuring transfer mode.

In general the patchset is OK, but there are comments...  (see 
forthcoming emails)

	Jeff



