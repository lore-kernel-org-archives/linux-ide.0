From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Sat, 08 Sep 2007 22:52:37 +0200
Message-ID: <46E30B95.10806@gmail.com>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org> <46D64AAA.7090808@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:51725 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbXIHUyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 16:54:13 -0400
Received: by rv-out-0910.google.com with SMTP id k20so719435rvb
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 13:54:13 -0700 (PDT)
In-Reply-To: <46D64AAA.7090808@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tom Evans wrote:
> In sil24_config_port, the writel's for /* zero error counters */ should
> be writew's - they are 16bit control registers.
> Only PORT_DECODE_ERR_THRESH and PORT_CRC_ERR_THRESH appear to be
> unaligned, but why risk a stl when a stw (on platforms that support it)
> can be used.

That part of the code was taken verbatim from the Silicon Image sample
driver, which I'm sure have been tested only on x86s.  Those error
threshold feature isn't really used and using writew's should be fine.
Do things work better after changing to writew's?

-- 
tejun
