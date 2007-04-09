From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: adding Pegasus IDE quirk for pata_via
Date: Mon, 09 Apr 2007 18:39:49 +0100
Message-ID: <461A7A65.2060505@genesi-usa.com>
References: <20070404111635.GA1855@aepfle.de>	<461A3C10.3050104@genesi-usa.com> <20070409154026.4d8a0774@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3530 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbXDIRjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 13:39:25 -0400
In-Reply-To: <20070409154026.4d8a0774@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Okay. I'll clean this up and submit a real patch to the Linux IDE mailing list (no point for
PowerPC guys to get any more of these since it is very generic Via IDE stuff now)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
>> Again some comments would be appreciated from anyone who has a better idea on how this controller
>> works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
>> based on his experiences with the chip and is so simple there cannot be much wrong with it
>> apart from coding style and a distinct lack of testing.
> 
> Seems sane to me - as you said the x86 world relies on the BIOS for this
> and in fact pretty much never uses native mode anyway.
> 
> Patch looks fine except pci_find_device is obsolete, please use
> pci_get_device and refcount safe APIs.
