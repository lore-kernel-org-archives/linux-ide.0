From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: warning of 2.6.37 kernel with gcc-4.5.2
Date: Thu, 03 Mar 2011 15:01:44 +0300
Message-ID: <4D6F8328.4070903@ru.mvista.com>
References: <E18F441196CA634DB8E1F1C56A50A8743241DEA698@IRVEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39868 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1CCMDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 07:03:07 -0500
Received: by bwz15 with SMTP id 15so1068447bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 03 Mar 2011 04:03:05 -0800 (PST)
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A8743241DEA698@IRVEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng@broadcom.com>
Cc: ide <linux-ide@vger.kernel.org>

Hello.

On 03-03-2011 4:12, Jian Peng wrote:

> While compiling 2.6.37 kernel with gcc-4.5.2 based toolchain for MIPS, there are a few warnings

[...]

> Those in fs/ubifs really bothers me since all of them are for debugging and gcc dislike them.

> Did anyone fix it in either changing Makefile or C codes? If not, I will post my patch to get rid of them.

    Why do you post this report to linux-ide, and not to linux-kernel? What 
does UBIFS code has to do with us?

> Thanks,
> Jian

WBR, Sergei
