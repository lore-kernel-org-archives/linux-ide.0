From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 06/13] ARM: davinci: da850: model the SATA refclk
Date: Thu, 19 Jan 2017 12:18:28 +0100
Message-ID: <CAMpxmJWmrwOnnUBHw_5_v9Fort_kphOE0x75hrat6_sXiyAvGg@mail.gmail.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-7-git-send-email-bgolaszewski@baylibre.com> <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

2017-01-18 18:26 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/18/2017 07:19 AM, Bartosz Golaszewski wrote:
>>
>>  int __init da850_register_sata(unsigned long refclkpn)
>>  {
>> +       int ret;
>> +
>>         /* please see comment in drivers/ata/ahci_da850.c */
>>         BUG_ON(refclkpn != 100 * 1000 * 1000);
>
>
> This BUG_ON() should be removed since the sata driver can now handle other
> clock frequencies.
>

Right, will fix in v4.

Thanks,
Bartosz Golaszewski
