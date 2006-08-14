From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
Date: Mon, 14 Aug 2006 14:28:12 -0400
Message-ID: <44E0C0BC.7020509@pobox.com>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210106.GO3543@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752051AbWHNS2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 14:28:22 -0400
In-Reply-To: <20060813210106.GO3543@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.18-rc3-mm2:
>> ...
>>  git-libata-all.patch
>> ...
>>  git trees
>> ...
> 
> This patch contains the following cleanups:
> - create a menu for ATA
> - replace the dependencies on ATA with an "if ATA"
>   as a side effect, this fixes a menu breakage due to SATA_INTEL_COMBINED
> - fix a typo in the PATA_OPTIDMA prompt
> - let ATA selet SCSI instead of depending on SCSI
>   this should make it easier for users to enable ATA (similar to USB_STORAGE)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

There have been a bunch of more-important changes to this file.  Please 
wait until Andrew pulls from me, and resend.

Thanks,

	Jeff



