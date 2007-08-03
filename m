From: Tejun Heo <htejun@gmail.com>
Subject: Re: Boot fails on Intel SATA controller
Date: Fri, 03 Aug 2007 20:00:38 +0900
Message-ID: <46B30AD6.20307@gmail.com>
References: <080220071649.26639.46B20B2D00011D1D0000680F2206424613CE05040A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:22718 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760320AbXHCLAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 07:00:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so649004rvb
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 04:00:45 -0700 (PDT)
In-Reply-To: <080220071649.26639.46B20B2D00011D1D0000680F2206424613CE05040A05@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Quel Qun <kelk1@comcast.net>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>, linux-ide@vger.kernel.org

Quel Qun wrote:
> ATA device, with non-removable media
> powers-up in standby; SET FEATURES subcmd spins-up.
>         Model Number:       HDS724040KLSA80                         
>         Serial Number:      KRFS11RAGT2EZC
>         Firmware Revision:  KFAOA20N
> Standards:
>         Used: ATA/ATAPI-7 T13 1532D revision 1 
>         Supported: 7 6 5 4 
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  268435455
>         LBA48  user addressable sectors:  781422768
>         device size with M = 1024*1024:      381554 MBytes
>         device size with M = 1000*1000:      400088 MBytes (400 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         Standby timer values: spec'd by Standard, no device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 8
>         Advanced power management level: unknown setting (0x0000)
>         Recommended acoustic management value: 128, current value: 128
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4 
>              Cycle time: no flow control=240ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    SMART feature set
>                 Security Mode feature set
>            *    Power Management feature set
>            *    Write cache
>            *    Look-ahead
>            *    Host Protected Area feature set

This is weird.  HPA is supported && enabled but
read_native_max_address_ext times out.  Can you post the result of
'hdparm --Istdout /dev/sda'?

-- 
tejun
