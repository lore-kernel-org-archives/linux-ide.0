From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 06/10] sata: ahci_da850: implement a softreset quirk
Date: Mon, 16 Jan 2017 11:17:22 +0100
Message-ID: <CAMpxmJWR6KkRyTtSSa56LKjX5=9U4R3ZvxXcrmkvw9uMissg1w@mail.gmail.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-7-git-send-email-bgolaszewski@baylibre.com> <20170115231208.GD14446@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170115231208.GD14446@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

2017-01-16 0:12 GMT+01:00 Tejun Heo <tj@kernel.org>:
> On Fri, Jan 13, 2017 at 01:38:00PM +0100, Bartosz Golaszewski wrote:
>> +static int ahci_da850_softreset(struct ata_link *link,
>> +                             unsigned int *class, unsigned long deadline)
>> +{
>> +     int pmp, ret;
>> +
>> +     pmp = sata_srst_pmp(link);
>> +
>> +     ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
>> +     if (pmp && ret == -EBUSY)
>> +             return ahci_do_softreset(link, class, 0,
>> +                                      deadline, ahci_check_ready);
>> +
>> +     return ret;
>> +}
>
> Please add some comments explaining what's going on.

Sure, I'll add some explanation in v2.

Thanks,
Bartosz Golaszewski
