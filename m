From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Mon, 19 Dec 2005 00:38:00 -0500
Message-ID: <43A64738.4090402@pobox.com>
References: <20051218081707.GA4129@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22149 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030282AbVLSFiD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:38:03 -0500
In-Reply-To: <20051218081707.GA4129@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Unlike their older siblings, ICH6 and 7 use different scheme for MAP
> VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.

Patch is OK, if tested has verified borne this out?

If this is not just a documentation error, it sounds like some of the 
ata_piix problems could be attributed to this.  We intentionally drive 
SATA and PATA differently...

	Jeff



