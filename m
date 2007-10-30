From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: flush is an IO command
Date: Tue, 30 Oct 2007 22:52:32 +0900
Message-ID: <47273720.90600@gmail.com>
References: <20071026065359.GL11853@htj.dyndns.org> <47273276.3040204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:8054 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbXJ3Nwk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:52:40 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1880638rvb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 06:52:39 -0700 (PDT)
In-Reply-To: <47273276.3040204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu

Jeff Garzik wrote:
> Tejun Heo wrote:
>> ATA_QCFLAG_IO is used to mark commands which are used to perform
>> regluar IO transfers via block layer.  These commands are assumed to
>> be valid and taken more seriously during error handling.  Cache flush
>> is used by regular IO path and necessary for data integrity.  Mark it
>> with ATA_QCFLAG_IO.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-scsi.c |    3 +++
>>  1 file changed, 3 insertions(+)
> 
> patch series looks fine... ok for 2.6.24-rc?

Yeap, shouldn't be dangerous.  Thanks.

-- 
tejun
