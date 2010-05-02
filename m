From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Sun, 02 May 2010 21:57:11 +1000
Message-ID: <4BDD6897.7000002@gmail.com>
References: <4BDAE529.20903@gmail.com>	<201005010524.40949.marek.vasut@gmail.com>	<4BDBD4AB.8020200@gmail.com> <20100501113346.29225519@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64994 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0EBL5P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 May 2010 07:57:15 -0400
Received: by pwj9 with SMTP id 9so844755pwj.19
        for <linux-ide@vger.kernel.org>; Sun, 02 May 2010 04:57:11 -0700 (PDT)
In-Reply-To: <20100501113346.29225519@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sat, 01 May 2010 17:13:47 +1000
> Graeme Russ <graeme.russ@gmail.com> wrote:
> 
>> Hello,
>>
>> I have a CF slot mapped to a GP bus on a board I'm porting linux to. It is
>> wired in 8-bit Memory Mode only with only A0 - A3 mapped from the address
>> bus (starting at 0x20000000). I know the arrangement works as this board is
>> successfully accessing CF cards using existing proprietary firmware.
> 
> Our ATA/IDE driver stack only supports 16/32bit accesses for data. You
> can override the data_xfer methods in a driver to do 8bit transfers. That
> may be one problem you are seeing I guess.
> 

Bingo! Thanks - I simply hacked:

    ioread16_rep(data_addr, buf, words);
to:
    ioread8_rep(data_addr, buf, buflen);

(and similarly for the writes) in ata_sff_data_xfer() and it all "just
works (tm)":

[    2.106837] ata1.00: CFA: SanDisk SDCFH-1024, HDX 4.04, max PIO4
[    2.109659] ata1.00: 2001888 sectors, multi 0: LBA
[    2.111034] ata1.00: configured for PIO
[    2.114811] ata1.00: configured for PIO
[    2.116445] ata1: EH complete
[    2.130852] scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-10
HDX  PQ: 0 ANSI: 5
[    2.150821] sd 0:0:0:0: [sda] 2001888 512-byte logical blocks: (1.02
GB/977 MiB)
[    2.158847] sd 0:0:0:0: [sda] Write Protect is off
[    2.161977] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    2.177842]  sda: sda1
[    2.205838] sd 0:0:0:0: [sda] Attached SCSI removable disk

Now to do things right - I've traced everything back into
pata_platform_port_ops (.sff_data_xfer = ata_sff_data_xfer_noirq). So I
will need to create custom data_xfer_noirq and data_xfer functions for the
8-bit transfers. Is there an elegant way to override pata_platform's use of
ata_sff_data_xfer_noirq or will I need to also write a new version of
pata_platform as well?

Thanks

Graeme


