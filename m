From: Richard Scobie <r.scobie@clear.net.nz>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 20:43:36 +1300
Message-ID: <475110A8.5090709@clear.net.nz>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:37022 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXLAHou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 02:44:50 -0500
In-Reply-To: <20071130231705.51e056f4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org



Alan Cox wrote:

> If you want really high performance use multiple drives, on multiple PCIE
> controllers. Just make sure your backup planning of raid 1+0 setup is
> done right as many drives means a lot more drive fails.

Thanks again. For what it's worth, I shall be attempting this with SATA 
drives in a RAID 50 configuration - 2 x 8 drives, using md RAID and an 8 
lane PCIe SAS HBA.

Regards,

Richard
