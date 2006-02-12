From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: implement ignore_PCS driver option
Date: Sun, 12 Feb 2006 14:19:50 -0500
Message-ID: <43EF8A56.3090706@pobox.com>
References: <20060212100841.GB20979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31194 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750874AbWBLTTz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:19:55 -0500
In-Reply-To: <20060212100841.GB20979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jfs@keytradebank.com, kmannth@gmail.com, 0602@eq.cz

Tejun Heo wrote:
> On some configurations, ICH5 SATA incorrectly reports 0 for PCS even
> when ports are active and operational.  This patch adds a driver
> parameter which, when set, causes ata_piix ignore PCS value and
> proceed with device probing.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Given my comments in the last email, after reviewing the docs, I think 
we should fix ata_piix SATA probe behavior before considering this 
patch.  Fixing ata_piix may make this patch unnecessary.

	Jeff



