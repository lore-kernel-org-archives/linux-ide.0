From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
Date: Fri, 01 May 2009 20:05:06 -0400
Message-ID: <49FB8E32.1050100@garzik.org>
References: <1241211767-32697-1-git-send-email-fkan@amcc.com> <20090501232040.3E59283420E8@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58267 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171AbZEBAFL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 May 2009 20:05:11 -0400
In-Reply-To: <20090501232040.3E59283420E8@gemini.denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Mark Miesfeld <miesfeld@gmail.com>

Wolfgang Denk wrote:
> Dear Feng Kan,
> 
> In message <1241211767-32697-1-git-send-email-fkan@amcc.com> you wrote:
>> This adds support for the Designware SATA controller.
>>
>> Signed-off-by: Feng Kan <fkan@amcc.com>
>> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
>> ---
>>  drivers/ata/Kconfig    |   10 +
>>  drivers/ata/Makefile   |    1 +
>>  drivers/ata/sata_dwc.c | 2053 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 2064 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/ata/sata_dwc.c
> 
> ...
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
>> +MODULE_DESCRIPTION("DesignWare Cores SATA controller low lever driver");
> ------------------------------------------------------------^^^^^
> 
> Guess that's a typo?

heh


> Hmm... that's 2000+ lines of code in a single file. Maybe this should
> be split?

A single file is just fine.

	Jeff


