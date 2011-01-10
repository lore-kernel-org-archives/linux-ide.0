From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ide: no need to check for the rq pointer to be NULL
Date: Mon, 10 Jan 2011 21:03:57 +0300
Message-ID: <4D2B4A0D.7040102@ru.mvista.com>
References: <20110109235146.GA5353@white.fsl.cs.sunysb.edu> <4D2AFACB.3040909@ru.mvista.com> <20110110173044.GA3495@white.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54565 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab1AJSFU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 13:05:20 -0500
Received: by eye27 with SMTP id 27so8721190eye.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 10:05:19 -0800 (PST)
In-Reply-To: <20110110173044.GA3495@white.fsl.cs.sunysb.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vasily Tarasov <sectorsize512@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, davem@davemloft.net, linux-ide@vger.kernel.org

Vasily Tarasov wrote:

> Ooops, you're right, ide_kill_rq() sets  hwif->rq (and rq in turn) to NULL.

    Frankly speaking, I don't see where...

WBR, Serge
