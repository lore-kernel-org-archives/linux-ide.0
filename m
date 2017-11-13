From: Tejun Heo <tj@kernel.org>
Subject: Re: Manual unbind of ATA devices causes use-after-free
Date: Mon, 13 Nov 2017 12:10:37 -0800
Message-ID: <20171113201037.GL983427@devbig577.frc2.facebook.com>
References: <150957868766.7160.13267337838101258462@takondra-t460s>
 <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
 <150972673653.5502.7168940193960185267@takondra-t460s>
 <20171106152452.GA3252168@devbig577.frc2.facebook.com>
 <151060376750.7561.9196983678072496472@takondra-t460s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <151060376750.7561.9196983678072496472@takondra-t460s>
Sender: linux-kernel-owner@vger.kernel.org
To: Taras Kondratiuk <takondra@cisco.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com, Lin Ming <minggr@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Nov 13, 2017 at 12:09:27PM -0800, Taras Kondratiuk wrote:
> > cc'ing Lin.  Lin, can you take a look at this?
> 
> I'm ready to test whenever you have something. If you don't have time to
> look at this then can you recommend a proper way to fix it. Is it better
> to change device hierarchy back to previous state (revert 9a6d6a2ddabb)
> or add reference counting to ata_host?

We'll have to add refcnting to ata_host.

Thanks.

-- 
tejun
