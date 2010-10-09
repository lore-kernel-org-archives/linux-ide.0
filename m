From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4] pata_sil680: implement sff_irq_check() method
Date: Sat, 09 Oct 2010 16:14:33 +0400
Message-ID: <4CB05CA9.6040904@ru.mvista.com>
References: <201010081901.08447.sshtylyov@ru.mvista.com> <20101008173612.2c633c4a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34313 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab0JIMQU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 08:16:20 -0400
Received: by ewy20 with SMTP id 20so31243ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 09 Oct 2010 05:16:19 -0700 (PDT)
In-Reply-To: <20101008173612.2c633c4a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 08-10-2010 20:36, Alan Cox wrote:

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

>> ---
>> The patch is against the recent Linus' tree.

> Same question again for these other two - test environment, results,
> reason it is needed ?

    Answered under the pata_cmd640 patch thread.

MBR, Sergei
