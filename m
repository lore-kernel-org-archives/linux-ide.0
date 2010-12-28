From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: clarify about HPT371N support
Date: Tue, 28 Dec 2010 16:04:10 +0300
Message-ID: <4D19E04A.5050703@ru.mvista.com>
References: <201012252101.17818.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55371 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0L1NFQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 08:05:16 -0500
Received: by eye27 with SMTP id 27so4217995eye.19
        for <linux-ide@vger.kernel.org>; Tue, 28 Dec 2010 05:05:14 -0800 (PST)
In-Reply-To: <201012252101.17818.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hello.

On 25-12-2010 21:01, I wrote:

> Commit 28e21c8c0d44cd63bad4c62f94ef0c5a1cb8402c (pata_hpt3x2n: Add HPT371N
> support and other bits) forgot to update both the driver's Kconfig entry and
> heading comment which may confuse users...

    I've noticed that the module description also wasn't updated, so there's 
gonna be v2 of this patch...

> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

WBR, Sergei
