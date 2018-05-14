From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.
Date: Mon, 14 May 2018 08:32:42 -0700
Message-ID: <20180514153242.GB2368884@devbig577.frc2.facebook.com>
References: <20180513181115.20541-1-fcami@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180513181115.20541-1-fcami@fedoraproject.org>
Sender: linux-kernel-owner@vger.kernel.org
To: fcami@fedoraproject.org
Cc: hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, May 13, 2018 at 08:11:15PM +0200, fcami@fedoraproject.org wrote:
> From: François Cami <fcami@fedoraproject.org>
> 
> Without this patch the drive errors out regularly:
> 
> [    1.090154] ata1.00: ATA-8: SAMSUNG SSD PM830 mSATA 256GB,
> CXM13D1Q, max UDMA/133
> (...)
> [  345.154996] ata1.00: exception Emask 0x40 SAct 0x0 SErr 0xc0800 action 0x6
> [  345.155006] ata1.00: irq_stat 0x40000001
> [  345.155013] ata1: SError: { HostInt CommWake 10B8B }
> [  345.155018] ata1.00: failed command: SET FEATURES
> [  345.155032] ata1.00: cmd ef/05:e1:00:00:00/00:00:00:00:00/40 tag 7
>                         res 51/04:e1:00:00:00/00:00:00:00:00/40 Emask 0x41 (internal error)
> [  345.155038] ata1.00: status: { DRDY ERR }
> [  345.155042] ata1.00: error: { ABRT }
> [  345.155051] ata1: hard resetting link
> [  345.465661] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  345.466955] ata1.00: configured for UDMA/133
> [  345.467085] ata1: EH complete
> 
> Signed-off-by: François Cami <fcami@fedoraproject.org>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
