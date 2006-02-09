From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/11] sata_sil: convert to new reset mechanism
Date: Thu, 09 Feb 2006 02:05:47 -0500
Message-ID: <43EAE9CB.1070801@pobox.com>
References: <11388720002615-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:45209 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422841AbWBIHFx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 02:05:53 -0500
In-Reply-To: <11388720002615-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_sil to use new reset mechanism.  sata_sil is fairly
> generic and can directly use std routine.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 5-6, pending addressing of comments in email
<43EAE67D.6010304@pobox.com>, the reply to patch #0 of this series.

Will wait for resend to apply patches 5+ of this series.

