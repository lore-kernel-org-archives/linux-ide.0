From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] libahci: Allow drivers to override stop_engine
Date: Tue, 24 Apr 2018 08:22:36 +0200
Message-ID: <20180424062236.GA14537@kroah.com>
References: <1524542805-11349-1-git-send-email-xswang@marvell.com>
 <1524542805-11349-2-git-send-email-xswang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524542805-11349-2-git-send-email-xswang@marvell.com>
Sender: stable-owner@vger.kernel.org
To: xswang@marvell.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, oferh@marvell.com, dingwei@marvell.com, xigu@marvell.com, nadavh@marvell.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 24, 2018 at 12:06:44PM +0800, xswang@marvell.com wrote:
> From: Evan Wang <xswang@marvell.com>
> 
> Marvell armada37xx, armada7k and armada8k share the same
> AHCI sata controller IP, and currently there is an issue
> (Errata Ref#226)that the SATA can not be detected via SATA
> Port-MultiPlayer(PMP). After debugging, the reason is
> found that the value of Port-x FIS-based Switching Control
> (PxFBS@0x40) became wrong.
> According to design, the bits[11:8, 0] of register PxFBS
> are cleared when Port Command and Status (0x18) bit[0]
> changes its value from 1 to 0, i.e. falling edge of Port
> Command and Status bit[0] sends PULSE that resets PxFBS
> bits[11:8; 0].
> So it needs save the port PxFBS register before PxCMD
> ST write and restore the port PxFBS register afterwards
> in ahci_stop_engine().
> 
> This commit allows drivers to override ahci_stop_engine
> behavior for use by the Marvell AHCI driver(and potentially
> other drivers in the future).
> 
> Signed-off-by: Evan Wang <xswang@marvell.com>
> Suggested-by: Ofer Heifetz <oferh@marvell.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/ata/ahci.c          |  6 +++---
>  drivers/ata/ahci.h          |  7 +++++++
>  drivers/ata/ahci_qoriq.c    |  2 +-
>  drivers/ata/ahci_xgene.c    |  4 ++--
>  drivers/ata/libahci.c       | 20 ++++++++++++--------
>  drivers/ata/sata_highbank.c |  2 +-
>  6 files changed, 26 insertions(+), 15 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
