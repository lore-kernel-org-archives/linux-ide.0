From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Sun, 09 Mar 2008 14:13:49 +0900
Message-ID: <47D3720D.7040004@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA> <47D1E91D.8090704@gmail.com> <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA> <47D371F5.1020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:60763 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYCIFNz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 00:13:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so722101rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 21:13:54 -0800 (PST)
In-Reply-To: <47D371F5.1020804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Unless I'm mistaken, this means that the BIOS is disabling SSP during
> POST, which it really shouldn't.  There's no guarantee that a hardreset
> won't occur even if the OS doesn't do it explicitly and when that
> happens the drive will get locked and OS can't unlock it without asking
> the user for password.  Eeeeek, ugly.
> 
>  specified, The attached patch implements ahci.skip_host_reset module
> parameter.  If specified, host reset is skipped during controller
> initialization.  Does this work around the problem?

Oh, and if it does, please post the result of "hdparm -I" after booting.

-- 
tejun
