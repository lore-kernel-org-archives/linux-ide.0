From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata Port Multiplier
Date: Thu, 12 Jul 2007 12:10:16 +0900
Message-ID: <46959B98.1000300@gmail.com>
References: <001801c7c3fd$5a735ac0$0202fea9@pav>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:54811 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761188AbXGLDKZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 23:10:25 -0400
Received: by wr-out-0506.google.com with SMTP id i30so13425wra
        for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 20:10:21 -0700 (PDT)
In-Reply-To: <001801c7c3fd$5a735ac0$0202fea9@pav>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Stephens <richard@memory-map.com>
Cc: linux-ide@vger.kernel.org

Richard Stephens wrote:
> Quick question: Does the kernel version 2.6.20 include support for Port
> Multipliers?

No.

> A little background: I have a non-working system with SiI3124 and SiI3726
> chips, and the manufacturer (NORCO) has sent me a link to your patch
> libata-tj-2.6.17.4-20060710. Since you don't have a patch for 2.6.20, I
> assume that functionality was merged into the main kernel. If not, how would
> I go about patching 2.6.20 to add port multiplier support?

Not yet.  I have patches against 2.6.22-rc6 in home-tj.org page tho.
Patches against 2.6.22 will be posted soon and I think it's gonna be
merged into 2.6.23 finally.

Thanks.

-- 
tejun
