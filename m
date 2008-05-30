From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: fix macbook ich8m problems
Date: Fri, 30 May 2008 18:11:15 -0400
Message-ID: <48407B83.90303@garzik.org>
References: <483EA9D6.6040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44919 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYE3WLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:19 -0400
In-Reply-To: <483EA9D6.6040402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>

Tejun Heo wrote:
> ICH8M on macbooks are peculiar in that some of them lock up when the
> second port is enabled, some return bogus values on SIDPR access while
> yet others hang on SIDPR access.  Also, the ich8m_apple_sata entry was
> wrongly added below generic ich8m entry making it virtually useless.
> 
> This patch works around macbook ich8m problems by
> 
> * moving ich8m_apple_sata entry above generic ich8m entry
> * dropping PIIX_FLAG_SIDPR from ich8m_apple_sata
> * adding subsystem 106b:00a1 as ich8m_apple_sata
> 
> Reported and tested by MATSUBAYASHI.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied



