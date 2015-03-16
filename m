From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH 01/35 linux-next] ata: constify of_device_id array
Date: Mon, 16 Mar 2015 23:16:59 +0100
Message-ID: <CAFLxGvybHX_h5qmS3k80GFtKCRFaK8f9xxh-6KCT7ZuMVRwrpw@mail.gmail.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
	<1426533469-25458-2-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533469-25458-2-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Fabian,

On Mon, Mar 16, 2015 at 8:17 PM, Fabian Frederick <fabf@skynet.be> wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Do you know the gcc plugin-system?
You could improve the const plugin in to find more interesting structs
to constify them.
http://grsecurity.net/~ephox/const_plugin/
Please check also the latest grsecurity patch.

-- 
Thanks,
//richard
