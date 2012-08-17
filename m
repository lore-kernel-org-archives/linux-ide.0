From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH] ata: Kconfig: Elaborate that SFF is meant for legacy and
 PATA stuff
Date: Fri, 17 Aug 2012 13:32:01 -0400
Message-ID: <502E8011.20701@pobox.com>
References: <1344808456.4275.66.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:55696 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2HQRcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:32:05 -0400
Received: by ghrr11 with SMTP id r11so4220712ghr.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:32:04 -0700 (PDT)
In-Reply-To: <1344808456.4275.66.camel@mattotaupa>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org

On 08/12/2012 05:54 PM, Paul Menzel wrote:
> Date: Sun, 12 Aug 2012 23:43:42 +0200
>
> Building Linux for an ASUS Eee PC 701 4G with
>
>          ata2.00: CFA: SILICONMOTION SM223AC, , max UDMA/66
>          ata2.00: 7815024 sectors, multi 0: LBA
>          ata2.00: configured for UDMA/66
>          scsi 1:0:0:0: Direct-Access     ATA      SILICONMOTION SM n/=
a  PQ: 0 ANSI: 5
>          sd 1:0:0:0: [sda] 7815024 512-byte logical blocks: (4.00 GB/=
3.72 GiB)
>          sd 1:0:0:0: [sda] Write Protect is off
>          sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
>          sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
>           sda: sda1
>          sd 1:0:0:0: [sda] Attached SCSI disk
>          sd 1:0:0:0: Attached scsi generic sg0 type 0
>
> I followed the advice to not use the deprecated old PATA subsystem
>
>          ATA/ATAPI/MFM/RLL support (DEPRECATED)  --->
>
> and use the ATA subsystem instead.
>
>          Serial ATA and Parallel ATA drivers  --->
>
> Unfortunately I needed several tries to find out, that I needed the S=
=46F
> menu I had not selected before because I had never heard that term
> before. I think it would have helped me, to have PATA or legacy IDE i=
n
> that item=E2=80=99s name.
>
> Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
> ---
> If you can improve the commit summary, I would be thankful.
>
>   drivers/ata/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 2be8ef1..27cecd3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -115,7 +115,7 @@ config SATA_SIL24
>   	  If unsure, say N.
>
>   config ATA_SFF
> -	bool "ATA SFF support"
> +	bool "ATA SFF support (for legacy IDE and PATA)"
>   	default y
>   	help
>   	  This option adds support for ATA controllers with SFF

applied



