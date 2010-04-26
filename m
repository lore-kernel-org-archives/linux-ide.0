From: Tim Small <tim@seoss.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Mon, 26 Apr 2010 12:59:05 +0100
Message-ID: <4BD58009.40202@seoss.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com> <20100422223309.GA1883@crow.mawsonit.co.uk> <4BD1129E.6030104@gmail.com> <20100423203446.GF1883@crow.mawsonit.co.uk> <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com> <20100424051021.GG1883@crow.mawsonit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:42679 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0DZL73 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2010 07:59:29 -0400
In-Reply-To: <20100424051021.GG1883@crow.mawsonit.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Mawson <richard@crow.mawsonit.co.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 24/04/10 06:10, Richard Mawson wrote:
> Thank you for your help with this. I believe this was a hardware problem, as the same
> pci-pcie converter with the same pcie sata adapter work perfectly in a different
> system (now why didn't I try that first..?)

If you want to try to debug this further - you could turn on PCI parity 
error detection (either using EDAC module, or via userspace with 
lspci/setpci)?

# modprobe  edac_core
# echo 1 > /sys/module/edac_core/parameters/check_pci_errors

If you're after a different solution for that machine, you can buy Sii 
3124 based cards (PCI-X to 4x SATA) for about the same price as that 
adaptor....

http://www.siliconimage.com/products/product.aspx?pid=27

Tim.


-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

