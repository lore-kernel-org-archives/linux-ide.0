From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/12] libata: modify ata_dev_try_classify
Date: Thu, 26 Jan 2006 23:20:24 -0500
Message-ID: <43D99F88.6080201@pobox.com>
References: <11380899223675-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:25018 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932166AbWA0EU3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:20:29 -0500
In-Reply-To: <11380899223675-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Make ata_dev_try_classify take @r_err to store tf error register value
> on completion and return device class instead of directly manipulating
> dev->class.  This is preparation for new reset mechanism.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 2-3


