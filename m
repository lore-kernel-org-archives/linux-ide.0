From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 00/10] ARM: da850-lcdk: add SATA support
Date: Fri, 13 Jan 2017 20:02:52 +0530
Message-ID: <fa513599-1ac1-51e9-4da3-f4ed61ba0ce2@ti.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday 13 January 2017 06:07 PM, Bartosz Golaszewski wrote:
> This series contains all the changes necessary to make SATA work on
> the da850-lcdk board.
> 
> The first patch adds a clock lookup entry required for the ahci core
> to retrieve a functional clock.
> 
> The second enables relevant config options for all davinci boards.
> 
> The third adds device tree bindings for the ahci_da850 driver.
> 
> The fourth adds a workaround for a SATA controller instability we
> detected after increasing the PLL0 frequency for proper LCD
> controller support.
> 
> Patches 5 through 7 extend the ahci_da850 driver - add DT support,
> un-hardcode the clock multiplier value and add a workaround for
> a quirk present on the da850 SATA controller.
> 
> Patches 8-10 add the device tree changes required to probe the driver.
> 
> I'm posting the series as a whole to give all reviewers the full
> picture and visibility of the changes required, if needed I can resend
> the patches separately.

I just tested this series on my LCDK board using a Western Digital SATA
HDD and it works great with some basic read / write tests. Thanks!

For the non-platform patches which I wont be queuing:

Tested-by: Sekhar Nori <nsekhar@ti.com>

I will take a look at the series closely next week.

Thanks,
Sekhar
