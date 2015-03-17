From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 01/35 linux-next] ata: constify of_device_id array
Date: Tue, 17 Mar 2015 19:48:16 +0100 (CET)
Message-ID: <833110133.20140.1426618096533.open-xchange@webmail.nmp.proximus.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533469-25458-2-git-send-email-fabf@skynet.be> <CAFLxGvybHX_h5qmS3k80GFtKCRFaK8f9xxh-6KCT7ZuMVRwrpw@mail.gmail.com>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailsec119.isp.belgacom.be ([195.238.20.115]:49970 "EHLO
	mailsec119.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753383AbbCQSsU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2015 14:48:20 -0400
In-Reply-To: <CAFLxGvybHX_h5qmS3k80GFtKCRFaK8f9xxh-6KCT7ZuMVRwrpw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>



> On 16 March 2015 at 23:16 Richard Weinberger <richard.weinberger@gmail.com>
> wrote:
>
>
> Fabian,
>
> On Mon, Mar 16, 2015 at 8:17 PM, Fabian Frederick <fabf@skynet.be> wrote:
> > of_device_id is always used as const.
> > (See driver.of_match_table and open firmware functions)
>
> Do you know the gcc plugin-system?
> You could improve the const plugin in to find more interesting structs
> to constify them.
> http://grsecurity.net/~ephox/const_plugin/
> Please check also the latest grsecurity patch.

Thanks a lot for information Richard, I didn't know about that project.

Regards,
Fabian

>
> --
> Thanks,
> //richard
