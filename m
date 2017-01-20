From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 06/14] ARM: davinci: da850: model the SATA refclk
Date: Fri, 20 Jan 2017 11:55:44 +0100
Message-ID: <CAMpxmJXnFM1VvPEQCMmpK3NASmMB3xFfJBxdWixrrOEz-FM7Ng@mail.gmail.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
 <1484832588-18413-7-git-send-email-bgolaszewski@baylibre.com> <fcbafcd6-4ecc-0f76-0f8c-960814c39423@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fcbafcd6-4ecc-0f76-0f8c-960814c39423@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

2017-01-20 11:52 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Thursday 19 January 2017 06:59 PM, Bartosz Golaszewski wrote:
>> Register a dummy clock modelling the external SATA oscillator for
>
> I had asked about this earlier. I dont think calling it a dummy clock is
> right. Can you fix it or respond to my earlier mail with any objections?
>

Sorry, I missed that - no objections against calling it a "fixed rate clock".

Thanks,
Bartosz
