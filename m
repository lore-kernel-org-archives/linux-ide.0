From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering
Date: Sun, 06 May 2007 00:13:46 +0400
Message-ID: <463CE57A.7050001@ru.mvista.com>
References: <200705010039.44580.sshtylyov@ru.mvista.com> <200705052130.17317.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:21039 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933275AbXEEUML (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 May 2007 16:12:11 -0400
In-Reply-To: <200705052130.17317.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Simplify UltraDMA mode filtering in the driver:

>>- make use of the newly introduced 'udma_mask' field of 'ide_pci_device_t' to
>>  set the correct hwif->ultra_mask, modifying init_setup_hpt366() to select
>>  the correct mask based on the chip revision;
>>
>>- replace 'max_mode' field of the 'struct hpt_info' with 'max_ultra' specifying
>>  the maximum UltraDMA mode allowed;
>>
>>- rewrite hpt3xx_udma_filter() to differ the filters based on the 'chip_type'
>>  field, and only use it for HPT366 and HPT370[A] where it's really necessary.
>>
>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

> I needed to fix some rejects because of the

    I was going to recast this patch once the fix below is verified...

> "hpt366: don't check enablebits for HPT36x" patch
> - please verify that I haven't broken anything.

> Thanks,
> Bart

MBR, Sergei
