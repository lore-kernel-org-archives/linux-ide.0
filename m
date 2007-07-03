From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: soft resetting port
Date: Tue, 03 Jul 2007 15:40:08 +0900
Message-ID: <4689EF48.8090506@gmail.com>
References: <1182260902.14805.60.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:31808 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbXGCGkN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:40:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2641942wah
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 23:40:12 -0700 (PDT)
In-Reply-To: <1182260902.14805.60.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-ide <linux-ide@vger.kernel.org>

Soeren Sonnenburg wrote:
> Dear List,
> 
> since the switch to 
> 
> CONFIG_ATA=y
> CONFIG_ATA_ACPI=y
> CONFIG_ATA_PIIX=y,
> 
> the ATA_PIIX driver manages both, internal sata disk aswell as cd/dvd
> rom. However I am being flooded with the error messages below (well they
> appear from time to time, dominating dmesg). 
> 
> This happens on kernel 2.6.22-rc5, I am copying relevant parts from dmesg:

Does 2.6.22-rc7 fare better?

-- 
tejun
