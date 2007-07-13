From: Tejun Heo <htejun@gmail.com>
Subject: Re: trouble with silicon image 680
Date: Fri, 13 Jul 2007 18:14:02 +0900
Message-ID: <4697425A.5020209@gmail.com>
References: <1184267244.46967becb38c2@gold3.portugalmail.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:2207 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761026AbXGMJOK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 05:14:10 -0400
Received: by nz-out-0506.google.com with SMTP id s18so393396nze
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 02:14:07 -0700 (PDT)
In-Reply-To: <1184267244.46967becb38c2@gold3.portugalmail.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: perazim@portugalmail.pt
Cc: linux-ide@vger.kernel.org

perazim@portugalmail.pt wrote:
> Trying to upgrade from FC4 to F7. Linux version 2.6.14-1.1656_FC4.
> Sorry but don't know the F7 kernel specifics. If this is a propblem,
> I will get them for you. Have Kouwell 571-B PCI ATA-133 card with the
> Silicon Image 0680 chipset connected to two dvd drives. Bios on card
> is most recent from SI website. When kernel boots, message is
> "pata_sil680: probe of 0000:00:0b.0 failed with error -16". This
> configuration worked fine in FC4. Have several systems with same
> hardware config and they all do this so it is not a failed card.
> 
> Is there a problem with the kernel?

-ENEEDMOREINFO.  Please try vanilla 2.6.22 and post full dmesg and the
result of 'lspci -nnvvv'.

-- 
tejun
