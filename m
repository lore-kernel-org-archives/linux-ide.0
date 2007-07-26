From: Tejun Heo <htejun@gmail.com>
Subject: Re: Re+: SATA hard drive no longer comes up as /dev/sda on 2.6.22
 with Intel ICH6M
Date: Thu, 26 Jul 2007 15:03:42 +0900
Message-ID: <46A8393E.4040603@gmail.com>
References: <469E2F81.8080002@alcatel-lucent.com> <469F1CFA.8030702@gmail.com> <469F594D.7040101@alcatel-lucent.com> <469F5A19.1040100@gmail.com> <469F75A6.2080706@alcatel-lucent.com> <46A00FFF.3030007@gmail.com> <46A104F7.1070602@alcatel-lucent.com> <46A18DDB.3040603@gmail.com> <46A4C235.7020901@alcatel-lucent.com> <46A5ACB1.9070005@gmail.com> <46A661C9.4010900@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:48764 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbXGZGDs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 02:03:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so20083rvb
        for <linux-ide@vger.kernel.org>; Wed, 25 Jul 2007 23:03:47 -0700 (PDT)
In-Reply-To: <46A661C9.4010900@alcatel-lucent.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "P.C.Chan" <pc.chan@alcatel-lucent.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello,

P.C.Chan wrote:
> The last straw which breaks the SATA support is
> "CONFIG_IDE_GENERIC=y".   Please see enclosed config files.
> 
> The description being:
> 
> *generic/default IDE chipset support (IDE_GENERIC)
> 
> If unsure, say Y.*
> 
> The linux distributions would have a hard time in preparing a kernel for
> general use,  when CONFIG_IDE_GENERIC and libata are somewhat mutally
> exclusive for Intel chipset.

Distros usually know better and don't build in the generic driver.  It's
built as a module and used only as the last resort.

> I guess it should at least say:
> 
> *If unsure, say N.*
> 
> It did no harm prior to 2.6.22 though.

That didn't to any harm probably because ATA quirk code reserved the
area for libata during PCI initialization, so the generic driver
couldn't grab the port before libata.  Now that the quirk is gone, the
generic driver grabs the first IDE channel before libata and you don't
have dma for your drive.

cc'ing Bartlomiej.  Bartlomiej, I think it would be better not to
default to Y for CONFIG_IDE_GENERIC.  For most cases, it just causes
misconfiguration and confusion these days.

Thanks.

-- 
tejun
