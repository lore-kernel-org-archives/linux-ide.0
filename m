From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix build warning in ata_scsi_var_len_cdb_xlat
Date: Wed, 28 Jun 2017 17:25:51 -0400
Message-ID: <20170628212551.GC32311@htj.duckdns.org>
References: <20170628200421.3047383-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170628200421.3047383-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Tom Yan <tom.ty89@gmail.com>, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Adam Manzanares <adam.manzanares@wdc.com>, Minwoo Im <dn3108@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Arnd.

On Wed, Jun 28, 2017 at 10:04:03PM +0200, Arnd Bergmann wrote:
> This new harmless warning just showed up:
> 
> drivers/ata/libata-scsi.c: In function 'ata_scsi_var_len_cdb_xlat':
> drivers/ata/libata-scsi.c:4194:1: error: label 'unspprt_sa' defined but not used [-Werror=unused-label]
> 
> The label is obviously unused and can be removed.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Already fixed a couple hours ago.  Sorry about the noise.

Thanks.

-- 
tejun
