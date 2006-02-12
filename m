From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] libata: implement ata_dev_id_c_string()
Date: Sun, 12 Feb 2006 14:25:44 -0500
Message-ID: <43EF8BB8.2020609@pobox.com>
References: <11397520242535-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:33754 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751428AbWBLTZu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:25:50 -0500
In-Reply-To: <11397520242535-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_dev_id_c_string() reads ATA string from the specified offset of
> the given IDENTIFY PAGE and puts it in the specified buffer in trimmed
> and NULL-terminated form.  The caller must supply a buffer which is
> one byte larger than the maximum size of the target ID string.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-5, though I think ata_dev_id_c_string() is beginning to become 
a long function name.

	Jeff



