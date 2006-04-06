From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/8] sata_sil24: enable 64bit
Date: Thu, 06 Apr 2006 12:46:07 -0400
Message-ID: <443545CF.9020904@pobox.com>
References: <11442437424186-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8376 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751273AbWDFQqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:46:09 -0400
In-Reply-To: <11442437424186-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Enable 64bit.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

tested with >4GB of memory, or at least with addresses >4GB?

	Jeff



