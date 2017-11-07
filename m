From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Tue, 7 Nov 2017 08:01:10 -0800
Message-ID: <CA+55aFxBEMsrqTPOST18iQ_VwNkFxqWq744W74M+8VVT2eL-3w@mail.gmail.com>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic> <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
 <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Nov 7, 2017 at 6:01 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Alternatively, we could brown-paper bag it with something like this:

This looks like a good thing to do regardless..

Because this is not really worth spending a ton of effort on debugging
(.. because IDE), but yes, the disassembly of the code clearly shows
that the problem here is that 'info' is NULL.

So adding the NULL guard and saying "we have a race somewhere in the
IDE layer" and not wasting any more time on it is almost certainly the
right thing to do.

Borislav, mind sending a signed-off patch or a pull request or whatever?

             Linus
