From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/9] ata: ceva: Move sata port phy oob settings to
 device-tree
Date: Sat, 21 Oct 2017 08:19:02 -0700
Message-ID: <20171021151902.GF1302522@devbig577.frc2.facebook.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
 <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 21, 2017 at 01:17:17PM +0200, Michal Simek wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> In SATA Speed negotiation happens with  OOB(Out of Band) signals. These OOB
> signal timing values are configured through vendor specific registers in the
> SATA controller. These OOB timings depends on the generator and detector clock
> frequency, which varies from board to board (ex: ep108 and zc1751 has different
> clock frequencies).
> To avoid maintaing these OOB settings in the driver, it is better to move these
> settings to the device-tree node and read from the device-tree.
> 
> This patch does the same.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
