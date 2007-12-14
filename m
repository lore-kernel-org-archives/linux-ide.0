From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 5/9] libata: add TOSHIBA MK1637GSX to spurious command
 completion list
Date: Fri, 14 Dec 2007 13:47:45 +0900
Message-ID: <47620AF1.7020904@gmail.com>
References: <200712140001.lBE01eOZ025438@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:20514 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbXLNErw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 23:47:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so803711rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 20:47:52 -0800 (PST)
In-Reply-To: <200712140001.lBE01eOZ025438@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, lakostis@altlinux.org, lakostis@altlinux.ru, thresh@altlinux.ru

akpm@linux-foundation.org wrote:
> From: "Konstantin A. Lepikhov" <lakostis@altlinux.org>
> 
> ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata1.00: spurious completions during NCQ issue=0x0 SAct=0x1 FIS=004040a1:00000020
> ata1.00: cmd 60/70:00:83:a6:f0/00:00:04:00:00/40 tag 0 cdb 0x0 data 57344 in
> 
> Device Model:     TOSHIBA MK1637GSX
> Serial Number:    77VBT1CRT
> Firmware Version: DL040D
> 
> Blacklist it.
> 
> Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9410
> 
> Signed-off-by: Konstantin A. Lepikhov <lakostis@altlinux.ru>
> Acked-by: Pavlov Konstantin <thresh@altlinux.ru>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This one should go away.  Spurious NCQ completion was bogus.

Thanks.

-- 
tejun
