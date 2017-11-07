From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Tue, 7 Nov 2017 21:06:26 +0800
Message-ID: <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Borislav,

On Tue, Nov 07, 2017 at 11:43:36AM +0100, Borislav Petkov wrote:
>On Tue, Nov 07, 2017 at 06:25:38PM +0800, Fengguang Wu wrote:
>> Hello,
>>
>> FYI this happens in v4.14-rc8 -- it's not necessarily a new bug.
>
>I can't repro here with your config. Can you send me your qemu command
>line too pls?

It turns out rather hard to reproduce -- that's the only occurrence in
100 boots. Perhaps we'll have to give up on this.

Fengguang
