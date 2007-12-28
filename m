From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/9] piix: remove stale comments
Date: Fri, 28 Dec 2007 15:02:14 +0300
Message-ID: <4774E5C6.90506@ru.mvista.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191200.1357.71766.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753832AbXL1MB6@vger.kernel.org>
In-Reply-To: <20071227191200.1357.71766.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/piix.c
> ===================================================================
> --- a/drivers/ide/pci/piix.c
> +++ b/drivers/ide/pci/piix.c
> @@ -8,53 +8,8 @@
>   *
>   *  May be copied or modified under the terms of the GNU General Public License
>   *
> - *  PIO mode setting function for Intel chipsets.
> - *  For use instead of BIOS settings.
> + * Documentation:
>   *
> - * 40-41
> - * 42-43
> - * 
> - *                 41
> - *                 43
> - *
> - * | PIO 0       | c0 | 80 | 0 |
> - * | PIO 2 | SW2 | d0 | 90 | 4 |
> - * | PIO 3 | MW1 | e1 | a1 | 9 |
> - * | PIO 4 | MW2 | e3 | a3 | b |
> - *
> - * sitre = word40 & 0x4000; primary
> - * sitre = word42 & 0x4000; secondary
> - *
> - * 44 8421|8421    hdd|hdb
> - *
> - * 48 8421         hdd|hdc|hdb|hda udma enabled
> - *
> - *    0001         hda
> - *    0010         hdb
> - *    0100         hdc
> - *    1000         hdd
> - *
> - * 4a 84|21        hdb|hda
> - * 4b 84|21        hdd|hdc
> - *
> - *    ata-33/82371AB
> - *    ata-33/82371EB
> - *    ata-33/82801AB            ata-66/82801AA
> - *    00|00 udma 0              00|00 reserved
> - *    01|01 udma 1              01|01 udma 3
> - *    10|10 udma 2              10|10 udma 4
> - *    11|11 reserved            11|11 reserved
> - *
> - * 54 8421|8421    ata66 drive|ata66 enable

    You could have left te progarmming info intact...

WBR, Sergei

