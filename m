From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/2] ata: ahci: add support for DaVinci DM816 SATA controller
Date: Fri, 24 Mar 2017 16:22:50 +0100
Message-ID: <CAMpxmJVppunC4HeXuyTXFno93HXoft2+k40JjEpjt5box4qAGg@mail.gmail.com>
References: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com> <1489489491-14195-3-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489489491-14195-3-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Patrick Titiano <ptitiano@baylibre.com>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

2017-03-14 12:04 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> This SATA controller is quite similar to the one present on the DA850
> SoC, but the PHY configuration is different and it supports two HBA
> ports.
>
> The IP suffers from the same PMP issue the DA850 does - if we enable
> PMP but don't use it - softreset fails. Appropriate workaround was
> implemented in this driver as well.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/ata/Kconfig      |   9 +++
>  drivers/ata/Makefile     |   1 +
>  drivers/ata/ahci_dm816.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 drivers/ata/ahci_dm816.c
>

Hi Tejun,

the DT bindings have been acked by Rob Herring and Tony Lindgren has
picked up the arch/arm patches. If there are no objections, could you
merge this driver and DT bindings for 4.12?

Thanks,
Bartosz
