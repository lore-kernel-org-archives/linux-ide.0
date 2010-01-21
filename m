From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 08/64] pata_cmd64x: fix PIO setup
Date: Wed, 20 Jan 2010 23:14:10 -0500
Message-ID: <4B57D492.1060508@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171455.14623.81852.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752538Ab0AUEOX@vger.kernel.org>
In-Reply-To: <20100118171455.14623.81852.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 01/18/2010 12:14 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_cmd64x: fix PIO setup
>
> Fix incorrect handling of recovery clocks value == 16 resulting
> in overclocked recovery timings&  potentially underclocked active
> timings.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_cmd64x.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

applied 8-11
