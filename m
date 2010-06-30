From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v1]460EX on-chip SATA driver<resubmisison>
Date: Wed, 30 Jun 2010 15:17:05 -0400
Message-ID: <4C2B9831.9020801@pobox.com>
References: <201006241327.o5ODRY6m032299@amcc.com> <20100630115808.2D9241524EC@gemini.denx.de> <3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com> <20100630184728.C02D014EBF9@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64328 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab0F3TRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 15:17:10 -0400
In-Reply-To: <20100630184728.C02D014EBF9@gemini.denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
Cc: Rupjyoti Sarmah <rsarmah@apm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sr@denx.de, linuxppc-dev@ozlabs.org

On 06/30/2010 02:47 PM, Wolfgang Denk wrote:
> Dear Rupjyoti Sarmah,
>
> In message<3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com>  you wrote:
>>
>> I took the mainline kernel v2.6.35-rc3 and downloaded using the git
>> download link.
>> I created the patch on 6/24/2010 after doing a git pull.
>
> I don;t think that you used v2.6.35-rc3; using this version, I still
> get this:
>
> drivers/ata/sata_dwc_460ex.c:43:1: warning: "DRV_NAME" redefined
> In file included from drivers/ata/sata_dwc_460ex.c:38:
> drivers/ata/libata.h:31:1: warning: this is the location of the previous definition
> drivers/ata/sata_dwc_460ex.c:44:1: warning: "DRV_VERSION" redefined
> drivers/ata/libata.h:32:1: warning: this is the location of the previous definition
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_scr_read':
> drivers/ata/sata_dwc_460ex.c:777: error: 'struct ata_port' has no member named 'ioaddr'
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_scr_write':
> drivers/ata/sata_dwc_460ex.c:793: error: 'struct ata_port' has no member named 'ioaddr'
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_error_intr':
> drivers/ata/sata_dwc_460ex.c:844: error: 'struct ata_port_operations' has no member named 'sff_check_status'

It looks like -your- build config is missing CONFIG_ATA_SFF or similar.

If you actually look at include/linux/libata.h, you see that struct 
ata_port_operations most definitely has a member named sff_check_status, 
for example.  Ditto ata_port and member ioaddr, etc.

	Jeff


