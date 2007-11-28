From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Wed, 28 Nov 2007 10:28:03 +0900
Message-ID: <474CC423.70705@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:60615 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbXK1B2L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:28:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1068437rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:28:11 -0800 (PST)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> Does 2.6.24-rc3 support SATA port multipliers?
> 
> I am getting "ata6.03: COMRESET failed (errno=-5)" error messages with a
> SiliconImage PMP connected to an Intel ICH9 SATA controller in AHCI
> mode.  

Yeah, it should work.

> Dmesg output attached.

Eeek.. Can you please tell me more about the configuration?  Which
devices are connected to which downstream port, etc...

Thanks.

-- 
tejun
