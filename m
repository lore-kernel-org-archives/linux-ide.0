From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] ata_piix: improve combined mode handling
Date: Tue, 28 Feb 2006 13:17:27 -0500
Message-ID: <440493B7.7060109@pobox.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36241 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932335AbWB1SRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 13:17:36 -0500
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This patchset is against the current upstream[1] + kill illegal
> kfree() patch[2].

30-second review:  looks OK, though I worry about patch #6.  I'll answer 
your questions and review in-depth later on.

	Jeff


