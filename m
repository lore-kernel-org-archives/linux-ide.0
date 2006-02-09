From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement ATA_FLAG_IN_EH port flag
Date: Thu, 09 Feb 2006 01:18:53 -0500
Message-ID: <43EADECD.2060203@pobox.com>
References: <11388093701287-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:11929 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422807AbWBIGTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:19:03 -0500
In-Reply-To: <11388093701287-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> ATA_FLAG_IN_EH flag is set on entry to EH and cleared on completion.
> This patch just sets and clears the flag.  Following patches will
> build normal qc execution / EH synchronization aroung this flag.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2


