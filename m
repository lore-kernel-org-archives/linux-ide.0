From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] pata_hpt37x: fold 'if' statement into 'switch'
Date: Mon, 10 Jan 2011 22:34:53 +0300
Message-ID: <4D2B5F5D.5080407@ru.mvista.com>
References: <201101102231.13495.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48155 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab1AJTgR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 14:36:17 -0500
Received: by ewy5 with SMTP id 5so8936968ewy.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 11:36:16 -0800 (PST)
In-Reply-To: <201101102231.13495.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hello.

I wrote:

> hpt37x_init_one() has a large *if* statement which should really be folded into
> the *switch* statement that currently constitutes its *else* branch, reducing
> one level of indentation...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Disregard "v2" in the subject -- forgot to remove it, when modifying the 
previous mail. :-)

WBR, Sergei
