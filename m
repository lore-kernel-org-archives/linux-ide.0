From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3] ata: fix Marvell SATA driver dependencies
Date: Thu, 27 Mar 2014 13:46:17 +0100
Message-ID: <53341D99.6070703@gmail.com>
References: <1668037.2oe7J2B7N4@amdc1032> <20140327123823.GM25349@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140327123823.GM25349@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 03/27/2014 01:38 PM, Andrew Lunn wrote:
> On Thu, Mar 27, 2014 at 01:23:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Make sata_mv host driver depend on PCI || ARCH_DOVE || ARCH_KIRKWOOD ||
>> ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X config options as Marvell
>> SATA support covers both Marvell PCI devices and Marvell Dove, Kirkwood,
>> MV78xx0, Armada 370/XP and Orion5x SoCs (for non-PCI devices the driver
>> to work requires suitable device tree node to be defined).
>
> Good old fashioned platform driver will also work. In fact, 95% of Orion5x
> and mv78xx0 devices don't have DT yet.
>
> You might also be able to simplify it to
>
> PCI || PLAT_ORION || COMPILE_TEST
>
> But i suggest you build test to make sure.

Please, don't do it. We are in the progress of getting rid of
PLAT_ORION. v3 is just fine, or keep at least ARCH_MVEBU:

PCI || PLAT_ORION || ARCH_MVEBU || COMPILE_TEST

Sebastian
