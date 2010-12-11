From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH] ata: pata_at91.c bugfix for high master clock
Date: Sat, 11 Dec 2010 06:40:45 +0300
Message-ID: <1292038845.6050.1.camel@homepc>
References: <1292011430-20835-1-git-send-email-plyatov@gmail.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292011430-20835-1-git-send-email-plyatov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com
List-Id: linux-ide@vger.kernel.org

Here is a typo in the patch description:
> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and pata_at91
> driver does detect ATA device.

"...driver DOES NOT detect ATA device."
