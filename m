From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
Date: Tue, 25 Sep 2018 11:49:59 +0530
Message-ID: <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org



On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>> Hi Kishon, Tejun,
>>
>> This patch series adds support for the SATA AHCI and PHY found on the
>> ARM-basd BCM63138 DSL SoCs.
>>
>> It would probably make sense for patches 1-3 to go through Kishon's
>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
>> two patches through the Broadcom ARM-SoC tree.
>>
>> Let me know if this is not a workable plan, thank you very much!
> 
> Looks like I had left patches with the incorrect subject, please
> disregard the following patches:
> 
> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
> DSL SoCs
> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
> 
> since they have incorrect/inconsistent titles, the other patches are
> fine though. Sorry about that.

merged the first 3 patches to linux-phy tree.

Thanks
Kishon
