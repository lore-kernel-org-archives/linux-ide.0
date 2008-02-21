From: Johann-Christoph Jacob <johann-christoph.jacob@fhtw-berlin.de>
Subject: Re: sata_sil24 not configuring drive right?
Date: Thu, 21 Feb 2008 13:26:38 +0100
Message-ID: <47BD6DFE.2080104@fhtw-berlin.de>
References: <47BB8346.4070400@fhtw-berlin.de> <47BBA66C.7050900@gmail.com> <47BC7D47.9060608@fhtw-berlin.de> <47BCD2A7.1030504@gmail.com> <47BD1FE4.2040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.rz.fhtw-berlin.de ([141.45.10.102]:54141 "EHLO
	mail2.rz.fhtw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYBUM1R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 07:27:17 -0500
In-Reply-To: <47BD1FE4.2040604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Thanks a lot! It seems WD built yet another unordinary drive.

Tejun Heo wrote:
> Tejun Heo wrote:
>>>>>         LBA, IORDY(can be disabled)
>>>>>         Queue depth: 1
>> Hmm... Here it is.  Interesting.  The drive is reporting queue depth of
>> 1.  Interesting.  This is the first time I see this.  The drive is
>> telling libata that it supports NCQ and the max queue depth is 1 and
>> libata configures it accordingly.  I'll ask wd about it.
> 
> Okay, confirmed.  The drive does support NCQ but have queue depth of 1,
> so nothing's wrong with your setup.  That's how the drive is built.
> 
> Thanks.
> 
