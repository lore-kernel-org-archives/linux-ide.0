From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Fri, 30 Nov 2007 01:06:44 +0900
Message-ID: <474EE394.6020604@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468181417-git-send-email-htejun@gmail.com> <20071129155546.694c6c45@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:18658 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbXK2QGz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:06:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1588842rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 08:06:55 -0800 (PST)
In-Reply-To: <20071129155546.694c6c45@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Alan Cox wrote:
> On Thu, 29 Nov 2007 23:33:28 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Depending on how many bytes are transferred as a unit, PIO data
>> tranasfer may consume more bytes than requested.  Knowing how much
>> data is consumed is necessary to determine how much is left for
>> draining.  This patch update ->data_xfer such that it returns the
>> number of consumed bytes.
> 
> Why do we care ? 
> 
> If the drive and controller disagree or the drive has gone off its
> trolley all we actually care about is when the thing stops saying there
> is data. In addition all our methods transfer the entire block they are
> asked to each time.

It's for draining.  Let's say drive says it wanna transfer 18 bytes but
the buffer is only 13 bytes long.  If the transfer method consumes 2
bytes per read, it would consume 14 bytes.  If the transfer method
consumes 4 bytes per read, it would consume 16 bytes.  If we drain too
much, we risk hanging the machine.

-- 
tejun
