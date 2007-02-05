From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream 2/2] pata_amd: don't configure udma
 mode faster than BIOS did
Date: Mon, 05 Feb 2007 21:36:51 +0900
Message-ID: <45C724E3.6000909@gmail.com>
References: <20070205080518.GI1625@htj.dyndns.org>	<20070205080801.GJ1625@htj.dyndns.org> <20070205112533.611558c2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:3850 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbXBEMg4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 07:36:56 -0500
Received: by an-out-0708.google.com with SMTP id b33so1006704ana
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 04:36:55 -0800 (PST)
In-Reply-To: <20070205112533.611558c2@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan wrote:
>> This patch implements mode_filter for pata_amd which makes it avoid
>> configuring udma mode higher than BIOS did.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK, wrong for the same reason as it is wrong on the IDE one, and even
> more so as we will support hotplug and the like in time too.

Yeap, it's wrong for hotplug but...

1. I don't think PATA hotplug is gonna be popular and even if we get
autodetection wrong (slower than optimal, which is way better than
faster than possible) on hotplug, we can allow the user to tune it
afterwards.

2. We don't have any way to detect cable type reliably on that
controller, so getting cable type correctly automatically on hotplug is
impossible anyway.

Thanks.

-- 
tejun
