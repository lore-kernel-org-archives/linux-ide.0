From: Tejun Heo <tj@kernel.org>
Subject: Re: Manual unbind of ATA devices causes use-after-free
Date: Fri, 3 Nov 2017 06:19:37 -0700
Message-ID: <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
References: <150957868766.7160.13267337838101258462@takondra-t460s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150957868766.7160.13267337838101258462@takondra-t460s>
Sender: linux-kernel-owner@vger.kernel.org
To: Taras Kondratiuk <takondra@cisco.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Nov 01, 2017 at 04:24:47PM -0700, Taras Kondratiuk wrote:
> Manual unbind/remove unconditionally invokes devres_release_all which
> calls ata_host_release() and frees ata_host/ata_port memory while it is
> still being referenced (e.g as a parent of SCSI host).
> 
> Is there a reason why ata_host is using derves which is not refcounted?
> Does it make sense to add recounting to ata_host?

Hmm... the removal path is supposed to drain everything synchronously.
What kind of controller is it?

Thanks.

-- 
tejun
