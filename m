From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 not configuring drive right?
Date: Thu, 21 Feb 2008 15:53:24 +0900
Message-ID: <47BD1FE4.2040604@gmail.com>
References: <47BB8346.4070400@fhtw-berlin.de> <47BBA66C.7050900@gmail.com> <47BC7D47.9060608@fhtw-berlin.de> <47BCD2A7.1030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.246]:17491 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYBUGxc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 01:53:32 -0500
Received: by hs-out-0708.google.com with SMTP id 54so2630036hsz.5
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 22:53:31 -0800 (PST)
In-Reply-To: <47BCD2A7.1030504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johann-Christoph Jacob <johann-christoph.jacob@fhtw-berlin.de>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>>>>         LBA, IORDY(can be disabled)
>>>>         Queue depth: 1
> 
> Hmm... Here it is.  Interesting.  The drive is reporting queue depth of
> 1.  Interesting.  This is the first time I see this.  The drive is
> telling libata that it supports NCQ and the max queue depth is 1 and
> libata configures it accordingly.  I'll ask wd about it.

Okay, confirmed.  The drive does support NCQ but have queue depth of 1,
so nothing's wrong with your setup.  That's how the drive is built.

Thanks.

-- 
tejun
