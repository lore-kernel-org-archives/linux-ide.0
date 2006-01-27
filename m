From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/5] libata: don't do EDD handling if ->probe_reset is
 used
Date: Thu, 26 Jan 2006 23:30:57 -0500
Message-ID: <43D9A201.3060205@pobox.com>
References: <11382890432020-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26810 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932238AbWA0EbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:31:01 -0500
In-Reply-To: <11382890432020-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> EDD is never used with ->probe_reset.  Don't handle EDD special case
> in ata_dev_identify if ->probe_reset is in use.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Nobody uses EDD, we might as well just remove it completely.

	Jeff



