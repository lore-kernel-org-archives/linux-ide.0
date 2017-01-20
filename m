From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
Date: Fri, 20 Jan 2017 15:02:34 +0100
Message-ID: <CAMpxmJUPh9MZKwG6k6p_mo6niXNNT02JCDgXi4DPRH2Fk3yxng@mail.gmail.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <20170120132843.GA31487@mtj.duckdns.org>
 <86bcbb3c-87e4-3508-f4a6-26529f39d374@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <86bcbb3c-87e4-3508-f4a6-26529f39d374@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-devicetree <devicetree@vger.kernel.org>, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Tejun Heo <tj@kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

2017-01-20 14:56 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Tejun,
>
> On Friday 20 January 2017 06:58 PM, Tejun Heo wrote:
>> On Fri, Jan 20, 2017 at 12:21:51PM +0100, Bartosz Golaszewski wrote:
>>> This series contains all the changes necessary to make SATA work on
>>> the da850-lcdk board.
>>>
>>> The first patch adds DT bindings for the ahci-da850 driver.
>>>
>>> The second enables relevant modules in davinci_all_defconfig.
>>>
>>> Patches 03/14-06/14 modify the way the clocks are handled regarding
>>> SATA on the da850 platform. We modify the ahci driver to retrieve
>>> the clock via con_id and model the external SATA oscillator as
>>> a real clock.
>>>
>>> Patches 07/14-11/14 extend the ahci-da850 driver. Add DT support,
>>> implement workarounds necessary to make SATA work on the da850-lcdk
>>> board and un-hardcode the external clock multiplier.
>>
>> Please feel free to add
>>
>>  Acked-by: Tejun Heo <tj@kernel.org>
>>
>> to the all libata patches.  Please let me know how the patches should
>> be routed once other parts are settled.
>
> I believe you can queue the libata patches independently (patches 1, 4,
> 7, 8, 9, 10, 11). It looks like they have been written such that driver
> continues to work with existing platform code (Bartosz, please disagree
> if I am wrong). 1/14 still needs the ack from DT maintainers.
>

Patch 11/14 depends on 06/14. Other than that I think it should work
independently.

Thanks,
Bartosz
