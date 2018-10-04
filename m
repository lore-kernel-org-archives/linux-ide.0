From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 9/9] ARM: bcm63138: Enable SATA AHCI and PHY
Date: Thu, 4 Oct 2018 10:23:15 -0700
Message-ID: <0ac69ef8-21fb-7005-4eac-b00bf46870b9@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <20180920191646.18198-13-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-13-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

On 09/20/2018 12:16 PM, Florian Fainelli wrote:
> The Broadcom BCM963138DVT board has an eSATA port which is fully
> functional, turn on the AHCI controller and the companion SATA PHY.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to devicetree/next
-- 
Florian
