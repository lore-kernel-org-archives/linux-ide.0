From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 06 Dec 2007 00:13:18 +0900
Message-ID: <4756C00E.3060100@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<4755ABB3.6030907@garzik.org>	<4755FB90.50505@gmail.com>	<20071205124713.4d31c5e7@the-village.bc.nu>	<4756A1AE.4010205@gmail.com>	<20071205140119.532c1eb4@the-village.bc.nu>	<4756B415.404@gmail.com> <20071205144649.4bca7a3c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:10081 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbXLEPN0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 10:13:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so7198757wah
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 07:13:26 -0800 (PST)
In-Reply-To: <20071205144649.4bca7a3c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

Alan Cox wrote:
>> It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
>> we can put it in #testing and put it into #upstream later.
> 
> Nobody cares about libata git trees. If you want some initial test
> coverage put it in -mm.

#for-testing ends up in #ALL which Andrew always includes in -mm.
#upstream also ends up in #ALL but is different in that it will get into
mainline when the next -rc1 opens.  Jeff, right?

-- 
tejun
