From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ata: ahci_brcm: Recover from failures to identify
 devices
Date: Tue, 16 Jan 2018 08:09:32 -0800
Message-ID: <20180116160932.GP3460072@devbig577.frc2.facebook.com>
References: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 11, 2018 at 05:31:06PM -0800, Florian Fainelli wrote:
> Hi Tejun, Kishon,
> 
> This patch series implement a recovery mechanism to work around a HW bug
> on Broadcom AHCI SATA controller subject to noise triggering a failure to
> identify hard drives.
> 
> I would like to make this this is okay with you as an approach on how to solve
> this.
> 
> This should likely go through Tejun's tree to make sure the SATA controller
> and PHY changes are bundled together.

libata part looks good to me.  Once phy side gets acked, I'll route
both through libata.

Thanks.

-- 
tejun
