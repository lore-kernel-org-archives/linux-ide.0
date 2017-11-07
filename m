From: Borislav Petkov <bp@alien8.de>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Tue, 7 Nov 2017 11:43:36 +0100
Message-ID: <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Nov 07, 2017 at 06:25:38PM +0800, Fengguang Wu wrote:
> Hello,
> 
> FYI this happens in v4.14-rc8 -- it's not necessarily a new bug.

I can't repro here with your config. Can you send me your qemu command
line too pls?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
