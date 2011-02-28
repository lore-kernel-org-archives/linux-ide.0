From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: How to debug not working dma mode
Date: Mon, 28 Feb 2011 21:25:33 +0100
Message-ID: <AANLkTi=pfcEaiOcpNOtDVy6CL_zV=U97XPtad6xGuGf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48103 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1B1U0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2011 15:26:44 -0500
Received: by vxi39 with SMTP id 39so3503879vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2011 12:26:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I am developing for an embedded device (geode lx800 based) and run into some
problems with a compact flash and dma.
If i enable dma with libata.dma=4 the kernel (2.6.36.4) hangs. So I am
looking for a
way to debug this situation and maybe even fix it. Any ideas how to proceed?

thanks,
--
Christian Gmeiner, MSc
