From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add refcounting to ata_host
Date: Tue, 13 Mar 2018 13:29:38 -0700
Message-ID: <20180313202938.GI2943022@devbig577.frc2.facebook.com>
References: <20171113201037.GL983427@devbig577.frc2.facebook.com>
 <1520584481-9643-1-git-send-email-takondra@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520584481-9643-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taras Kondratiuk <takondra@cisco.com>
Cc: Lin Ming <minggr@gmail.com>, xe-linux-external@cisco.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 09, 2018 at 08:34:41AM +0000, Taras Kondratiuk wrote:
> After commit 9a6d6a2ddabb ("ata: make ata port as parent device of scsi
> host") manual driver unbind/remove causes use-after-free.
> 
> Unbind unconditionally invokes devres_release_all() which calls
> ata_host_release() and frees ata_host/ata_port memory while it is still
> being referenced as a parent of SCSI host. When SCSI host is finally
> released scsi_host_dev_release() calls put_device(parent) and accesses
> freed ata_port memory.
> 
> Add reference counting to make sure that ata_host lives long enough.
> 
> Bug report: https://lkml.org/lkml/2017/11/1/945
> Fixes: 9a6d6a2ddabb ("ata: make ata port as parent device of scsi host")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lin Ming <minggr@gmail.com>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
