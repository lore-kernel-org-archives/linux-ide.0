From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix compile warning caused by ignoring __must_check
 results
Date: Tue, 23 Jan 2007 02:07:05 +0900
Message-ID: <45B4EF39.2010006@gmail.com>
References: <20070120052329.GB24749@htj.dyndns.org> <20070122112945.772a1c40@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:54750 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbXAVRHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 12:07:14 -0500
Received: by wr-out-0506.google.com with SMTP id 68so745041wra
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 09:07:14 -0800 (PST)
In-Reply-To: <20070122112945.772a1c40@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan wrote:
> On Sat, 20 Jan 2007 14:23:29 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Fix compile warnings in pata_cs5530, sata_inic162x and sata_nv which
>> are caused by throwing away return values marked with __must_check.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK NAK NAK NAK NAK NAK
> 
> As was previously discussed the bug is the bogus __must_check on
> pci_set_mwi. That __must_check should be removed and that was also the
> decision before but nothing happened. Please therefore get the pci header
> fixed.

That works for me too.  I'll drop pci_set_mwi() part.

Thanks.

-- 
tejun
