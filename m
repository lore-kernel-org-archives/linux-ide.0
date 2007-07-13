From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/15] libata-pmp: extend ACPI support to cover PMP
Date: Fri, 13 Jul 2007 12:05:24 +0900
Message-ID: <4696EBF4.4020907@gmail.com>
References: <11832872541728-git-send-email-htejun@gmail.com> <46968E0B.9090307@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:36927 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbXGMDF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 23:05:29 -0400
Received: by py-out-1112.google.com with SMTP id d32so538286pye
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 20:05:29 -0700 (PDT)
In-Reply-To: <46968E0B.9090307@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Extend ata_acpi_associate_sata_port() such that it can handle PMP and
>> call it when PMP is attached and detached.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Though not your fault, I predict much puking of BIOS code, when PMP are
> attached and suspend/whatever ACPI-related.  I doubt ACPI writers take
> PMP into account.

In most cases, ACPI just would be disabled when PMP is attached and
reenabled when detached, so it should be generally okay.  I'm not sure
if anyone would implement PMP ACPI methods but at least one vendor is
selling a motherboard with on-board PMP, so maybe....

-- 
tejun
