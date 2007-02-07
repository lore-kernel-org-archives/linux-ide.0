From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems (and confusions) with Intel ICH7 SATA controller
Date: Wed, 07 Feb 2007 13:34:18 +0900
Message-ID: <45C956CA.80709@gmail.com>
References: <1170536373.7892.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:64939 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030632AbXBGRzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 12:55:24 -0500
Received: by nz-out-0506.google.com with SMTP id s1so246635nze
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2007 09:55:24 -0800 (PST)
In-Reply-To: <1170536373.7892.5.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-ide@vger.kernel.org

Florian Echtler wrote:
> Hello everybody,
> 
> I hope this is the right place to ask.. :-)
> 
> I have an Acer Aspire 5550 laptop with Core Solo processor and the Intel
> ICH7 Chipset. Most of the hardware works fine, with the exception of
> suspend-to-ram. 
> 
> I have a strong suspicion that the SATA controller is to blame for that,
> as I have tried every possible combination of s2ram parameters and still
> the display stays black upon resume, only the hard disk LED lights up
> and stays that way.
> 
> I have seen suggestions to try the ahci driver instead of the ata_piix
> driver, however, as far as I understand this would need switching the
> controller mode in BIOS. The BIOS is, unfortunately, utterly crippled
> and gives almost no options to change anything beyond the system clock.
> 
> Is this a known problem with ICH7? Can anybody give me some additional
> hints?

Which version of kernel are you using?

-- 
tejun

