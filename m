From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/12] sata_sil: convert to new reset mechanism
Date: Sat, 28 Jan 2006 13:27:59 -0500
Message-ID: <43DBB7AF.1060408@pobox.com>
References: <1138089922913-git-send-email-htejun@gmail.com> <43DBB34B.1050302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47049 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932442AbWA1S2E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jan 2006 13:28:04 -0500
In-Reply-To: <43DBB34B.1050302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Jeff Garzik wrote:
> If the driver can access the SATA PHY registers, the very first thing it 
> should usually do is the code in sata_std_hardreset()... everything 
> except the 0x301 value write.

...and possibly the device classification.  Probably want to do a soft 
reset, then get the signature.  Read the port multiplier spec PM 
initialization sequence...  that is a highly relevant description.

	Jeff


