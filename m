From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_nv: ata2 errors
Date: Thu, 01 Nov 2007 17:01:51 -0400
Message-ID: <472A3EBF.1080403@garzik.org>
References: <877aabc40710250048m41675163x81671097f44bba7f@mail.gmail.com> <20071101133102.1121bc28.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48427 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121AbXKAVCA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 17:02:00 -0400
In-Reply-To: <20071101133102.1121bc28.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Amit Shah <shahamit@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Thu, 25 Oct 2007 13:18:50 +0530
> "Amit Shah" <shahamit@gmail.com> wrote:
> 
>> On 2.6.24-rc1 (AMD Opteron 1216), my sata_nv driver produces this
>> output on bootup:
>>
>> ata2: EH in SWNCQ mode,QC:qc_active 0x1 sactive 0x1
>> ata2: SWNCQ:qc_active 0x1 defer_bits 0x0 last_issue_tag 0x0
>> ata2: ATA_REG 0x40 ERR_REG 0x0
>> ata2: tag : dhfis dmafis sdbfis sacitve
>> ata2: tag 0x0: 0 1 0 0
>> ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
>> ...
>> ata2.00: status: { DRDY }
>>
> 
> Are any other problems observeable?


2.6.24-rc1 is missing the fix for this that is upstream,
360737a982b1ae09e1659e0bb27085c03f02f404

	Jeff


