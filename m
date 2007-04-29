From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Mon, 30 Apr 2007 01:43:58 +0900
Message-ID: <4634CB4E.30402@gmail.com>
References: <010501c78736$aad2e480$0703a8c0@SJAWINXP> <20070426023534.68007582C@rmail.inner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:23634 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbXD2QoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 12:44:04 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1681221nzf
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 09:44:04 -0700 (PDT)
In-Reply-To: <20070426023534.68007582C@rmail.inner.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Metz <cmetz@inner.net>
Cc: "Steven J. Ackerman" <sjackerman@comcast.net>, linux-ide@vger.kernel.org

Craig Metz wrote:
> In message <010501c78736$aad2e480$0703a8c0@SJAWINXP>, you write:
>>> Here are the Linux Kernel error messages that are produced by this
>>> kernel running on a Intel D865GLC motherboard trying to talk to our
>>> ARC-770 based adaptor on SATA-0 :
>>>
>>> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10 
>>> scsi2 : ata_piix ata1.00: CFA, max PIO4, 8005536 sectors: LBA 
>>> ata1.00: ata1: dev 0 multi count 0 ata1.00: qc timeout (cmd 0xef) 
>>> ata1.00: failed to set xfermode (err_mask=0x4)
>> Can you give a shot at 2.6.21-rc7.  The problem should have been fixed
>> there.
> 
>   I am also having problems with this device, but on both an ICH5 and on a
> VIA pre-AHCI SATA controller. I just tried 2.6.21-rc7 - it fails in exactly the
> same way as with 2.6.20.

Can you please post full dmesg?

-- 
tejun
