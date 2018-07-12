From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Guard ata_scsi_dump_cdb() by ATA_VERBOSE_DEBUG
Date: Thu, 12 Jul 2018 13:06:14 -0700
Message-ID: <20180712200614.GL72677@devbig577.frc2.facebook.com>
References: <fb36a7b0-74f6-2a0e-0826-fd1561ec7790@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fb36a7b0-74f6-2a0e-0826-fd1561ec7790@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 12, 2018 at 06:29:44PM +0200, Paul Menzel wrote:
> Date: Sun, 8 Jul 2018 09:11:34 +0200
> 
> Defining `ATA_DEBUG` nothing can be really seen, as the log is spammed
> with CDB messages.
> 
> Therefore, guard the print by `ATA_VERBOSE_DEBUG`.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to libata/for-4.19.

Thanks.

-- 
tejun
