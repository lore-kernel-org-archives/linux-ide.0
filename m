From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 47/64] ide: add drive->dma_mode field
Date: Mon, 12 Apr 2010 18:12:40 +0400
Message-ID: <4BC32A58.2040500@ru.mvista.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118172035.14623.50000.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100118172035.14623.50000.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add drive->dma_mode field
>
> Add dma_mode field to ide_drive_t matching dma_mode field used in
> struct ata_device.
>
> The validity of the field is restricted to ->dma_pio_mode method
> only currently in IDE subsystem.
>   

   I don't see such method even in your tree -- perhaps you meant 
set_dma_mode()?

MBR, Sergei
