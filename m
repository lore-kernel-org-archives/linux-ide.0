From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: don't do EDD handling if ->probe_reset is used
Date: Sun, 12 Feb 2006 14:29:23 -0500
Message-ID: <43EF8C93.9080109@pobox.com>
References: <20060212142237.GA7281@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:35290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750712AbWBLT30 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:29:26 -0500
In-Reply-To: <20060212142237.GA7281@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> EDD is never used with ->probe_reset.  Don't handle EDD special case
> in ata_dev_identify if ->probe_reset is in use.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> This patch should have been included in the reset patchset but was
> left out somehow, sorry.  This patch is generated on top of "misc
> preps for configuration reorganization" patchset[1] I've just posted
> but also applies over upstream with offset.

applied


