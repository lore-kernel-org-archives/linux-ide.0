From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU=?= =?utf-8?Q?=3A?= [v1] ahci: imx:
 setup power saving methods
Date: Sun, 29 Sep 2013 15:48:18 +0800
Message-ID: <20130929074817.GG26156@S2101-09.ap.freescale.net>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
 <20130929073528.GE26156@S2101-09.ap.freescale.net>
 <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:48033
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950Ab3I2Hr1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Sep 2013 03:47:27 -0400
Content-Disposition: inline
In-Reply-To: <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, Richard Zhu <richard.zhuhongxing@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Sep 29, 2013 at 07:40:57AM +0000, Zhu Richard-R65037 wrote:
> Hi Shawn:
> Thanks.
> The hot-plug can=E2=80=99t be supported, if we support this method un=
conditionally.

Ah, okay.  Then you should make this clear in the help text of the
Kconfig option.

Shawn

