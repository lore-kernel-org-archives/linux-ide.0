From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/12] libata: fix ata_acpi_gtm_xfermask()
Date: Tue, 27 Nov 2007 17:40:09 +0900
Message-ID: <474BD7E9.9070805@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com> <1194327551238-git-send-email-htejun@gmail.com> <47477B70.2000706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:17741 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXK0IkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 03:40:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so813141rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 00:40:15 -0800 (PST)
In-Reply-To: <47477B70.2000706@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> ata_acpi_gtm_xfermask() as separated out from pacpi_discover_modes()
>> has various bugs.  Fix them.
>>
>> * The wrong comparison operator is used when finding for matching
>>   cycle resulting totally bogus result.
>>
>> * With the comparion operator fixed, boundary condtion handling is
>>   clumsy.
>>
>> * Setting of any DMA mask bit set all bits in PIO mask.
>>
>> * MWDMA and UDMA blocks are swapped.
> 
> shouldn't this be combined with patch #6?

I did it that way at first but that made the patch difficult to review
because the content changes (bug fixes) are hidden by moving whole
function from pata_acpi to libata-acpi, so I separated out the fix part
into this patch.

Thanks.

-- 
tejun
