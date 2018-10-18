From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Thu, 18 Oct 2018 15:12:08 +0200
Message-ID: <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
        <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
        <20181018124118.GA10376@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018124118.GA10376@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 10/18/2018 02:41 PM, Christoph Hellwig wrote:
>> +static int __init pata_buddha_init_one(void)
>> +{
>> +	struct zorro_dev *z = NULL;
>> +
>> +	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> 
> I'm not really an m68k expert, but shouldn't this implement a
> struct zorro_driver instead?  (or maybe two of them as xsurf
> seems sufficiently different).

I didn't want to introduce too many changes over old IDE's
driver in the initial version of the libata driver as
I can't test them myself. Once the new driver is verified
to work I plan to convert it into proper Zorro_driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
