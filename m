From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 23/23] powerpc/4xx: Device tree update for the 460ex
 DWC SATA
Date: Thu, 21 Apr 2016 14:59:10 -0500
Message-ID: <CAL_JsqKGujmO32+Y5ptO_5muQeQ8cbL3S46iky-5mEcR2peAXA@mail.gmail.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-24-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58575 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbcDUT7h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Apr 2016 15:59:37 -0400
In-Reply-To: <1461262544-115408-24-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>

On Thu, Apr 21, 2016 at 1:15 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Device tree update for the Applied micro processor 460ex on-chip SATA to use
> "dmas" property.
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

I see you have maintained compatibility in the driver for old DTs, so:

Acked-by: Rob Herring <robh@kernel.org>
