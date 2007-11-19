From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Mon, 19 Nov 2007 22:05:06 +0900
Message-ID: <47418A02.2080801@gmail.com>
References: <47371586.9090409@tng.de> <47386F3E.8000906@gmail.com> <47407DD8.10301@tng.de> <47412E96.6070701@gmail.com> <474188A9.3020701@tng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:47449 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXKSNFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 08:05:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1959900wah
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2007 05:05:13 -0800 (PST)
In-Reply-To: <474188A9.3020701@tng.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Rohwer <tr@tng.de>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

Thomas Rohwer wrote:
>> One question.  Does macbook's firmware allow putting the controller into
>> ahci mode?
> 
> Do you mean, that one can configure the firmware, so that it puts the
> controller in ahci mode during boot? I don't know. There seems to be no
> user interface
> for the firmware. The refit bootloader is able to manipulate efi setting
> variables, but one would need some documentation to understand the
> meaning of them.
> 
> Or do you mean, that one can switch to ahci mode under linux?

I meant the former.  Can you post the result of "lspci -nnvvvxxx"?  Thanks.

-- 
tejun
