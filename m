From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci port hangs while hard resetting link
Date: Fri, 27 Aug 2010 11:01:39 +0200
Message-ID: <4C777EF3.90502@kernel.org>
References: <201008230010.48355.anssi.hannula@iki.fi>	<4C723FF4.1020208@kernel.org>	<201008231811.59828.anssi.hannula@iki.fi>	<4C73F2E3.6030909@kernel.org> <AANLkTimN0tg+mBGaU=BHmC1FyVWr8LXhdNC6FzV_7J57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59959 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab0H0JHi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Aug 2010 05:07:38 -0400
In-Reply-To: <AANLkTimN0tg+mBGaU=BHmC1FyVWr8LXhdNC6FzV_7J57@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-ide@vger.kernel.org

Hello,

On 08/27/2010 10:09 AM, Gwendal Grignou wrote:
> It is a good fix. We experience a similar issue [a bad drive was
> passing hard reset but would not answer a soft reset]. Without the
> patch the machine would hang. With it, the error is found. This
> problem has been introduced a long time ago, in commit
> 2cbb79ebbd4be07041368da5379a64f89f8ad518; it is there in 2.6.33, in
> drivers/ata/ahci.c. I can send you the trivial patch for it if you
> want, for stable kernel.

Oh, great, I'll send the patch with your Tested-by.  Thanks.

-- 
tejun
