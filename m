From: Tim Small <tim@seoss.co.uk>
Subject: Re: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and
 Intel s3610 SSDs
Date: Mon, 10 Aug 2015 16:35:03 +0100
Message-ID: <55C8C4A7.2050706@seoss.co.uk>
References: <20150809042756.GX4243@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.251.4]:54543 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346AbbHJQAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2015 12:00:37 -0400
In-Reply-To: <20150809042756.GX4243@bitfolk.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Smith <andy@strugglers.net>, linux-ide@vger.kernel.org

On 09/08/15 05:27, Andy Smith wrote:
> I've just put together a system based on a Supermicro X10SDV-F
> motherboard, which comes with an Intel C220 SATA controller. I've
> got two Intel DC s3610 SSDs plugged into this, and have
> intermittently been seeing the following ATA errors:
> 
> Jul 23 17:14:41 snaps kernel: [68044.504291]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> 

If you'd like to try and collect a few more data points:

Is there any useful info from smartctl -x ?  e.g. reset counters or
other logged errors - either drive internal errors or cabling/link
related "Sata Phy Event Counters" etc.?

Is attempting to ready SMART info status (e.g. through some daemon e.g.
munin hddtemp etc.) actually triggering these errors?  FWIW smartctl -x
seemed to elicit a reset on an Intel S3510 for me about 5 minutes ago.

Do the drives work any more reliably on a good PCIe card (such as an
asmedia ASM1061 controller, or Sil3132 = both < $15 assuming you are
able to add one) or do you see the same errors?

Have you checked the Intel docs for errata on either part?

Disabling NCQ may just be significant, or it may of course just be
slowing down throughput such that the error is less likely to occur -
assuming it's timing-related.


Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309
