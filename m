From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ide: Fix IDE PIO size calculation
Date: Thu, 20 Jun 2013 15:05:17 +0400
Message-ID: <51C2E1ED.8050606@cogentembedded.com>
References: <1371701667-3908-1-git-send-email-Steven.Hill@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:41336 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965343Ab3FTLFQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jun 2013 07:05:16 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so5601266lab.15
        for <linux-ide@vger.kernel.org>; Thu, 20 Jun 2013 04:05:15 -0700 (PDT)
In-Reply-To: <1371701667-3908-1-git-send-email-Steven.Hill@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc: "David S . Miller" <davem@davemloft.net>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, linux-ide@vger.kernel.org

Hello.

On 20-06-2013 8:14, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> IDE PIO calculates the size wrong when passing the parameter
> "ide-core.nodma=0.0" to the kernel.

> Change-Id: Id82c2bc5965d85960846db53d84846d9a05d75a3

   This line has no place in the upstream commit, and I've already told 
Leonid to get rid of it.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

WBR, Sergei

