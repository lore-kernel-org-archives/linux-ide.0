From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and
 ata_port_operations
Date: Sat, 09 Feb 2008 10:55:42 +0900
Message-ID: <47AD081E.2010001@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com> <200801310828.m0V8Scc0005066@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:14361 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbYBIBz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 20:55:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2708538rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 17:55:50 -0800 (PST)
In-Reply-To: <200801310828.m0V8Scc0005066@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, leoli@freescale.com

Akira Iguchi wrote:
> Tejun Heo wrote:
>> The following drivers need specific platform to build, so they need
>> verification.  If you work on one of the following drivers, please
>> verify that the driver builds and works fine.  It would be best if you
>> can verify that the sht and ops don't change by the fifth path using
>> the method I'll write in another message.
> ..
>> * pata_scc
> 
> I check pata_scc and it works fine.
> Your verification method detects 1 difference in ops
> (.thaw: NULL -> ata_bmdma_thaw) but there is no problem.

Thanks.  I'll fix that up.

-- 
tejun
