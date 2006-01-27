From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/13] libata: fold __ata_qc_complete() into ata_qc_free()
Date: Thu, 26 Jan 2006 22:34:03 -0500
Message-ID: <43D994AB.7090009@pobox.com>
References: <11379893763218-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59833 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932413AbWA0DeI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 22:34:08 -0500
In-Reply-To: <11379893763218-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> All ata_qc_free() does is calling __ata_qc_complete() which isn't used
> anywhere else.  Fold __ata_qc_complete() into ata_qc_free().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


