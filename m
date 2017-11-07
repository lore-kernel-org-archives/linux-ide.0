From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drivers/ide-cd: Handle missing driver data during status
 check gracefully
Date: Tue, 7 Nov 2017 09:13:04 -0800
Message-ID: <CA+55aFy+peFp-u753gu43L5eisPE8g-P_eCyx-amoBADm-k0NA@mail.gmail.com>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic> <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
 <20171107140102.n2pncsaer5o5hmt7@pd.tnic> <CA+55aFxBEMsrqTPOST18iQ_VwNkFxqWq744W74M+8VVT2eL-3w@mail.gmail.com>
 <20171107163723.7u5iyvewrrjglqif@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:51629 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbdKGRNF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2017 12:13:05 -0500
In-Reply-To: <20171107163723.7u5iyvewrrjglqif@pd.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 7, 2017 at 8:37 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Here it is:

Thanks, applied directly.

                 Linus
