From: Bram Matthys <syzop@vulnscan.org>
Subject: Re: Write performance 50% compared to Windows
Date: Wed, 2 Nov 2016 16:07:35 +0100
Message-ID: <6ce9014c-f30a-b29d-23ae-ffd820078af4@vulnscan.org>
References: <adf65b5b8edfe0c1c99bc55a2827a68d@mail.vulnscan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vulnscan.org ([149.210.174.15]:53017 "EHLO
        mail.vulnscan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbcKBPHh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2016 11:07:37 -0400
Received: from [37.152.11.94] (helo=[192.168.5.24])
        by mail.vulnscan.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <syzop@vulnscan.org>)
        id 1c1x8Y-0007Kl-CZ
        for linux-ide@vger.kernel.org; Wed, 02 Nov 2016 16:07:34 +0100
In-Reply-To: <adf65b5b8edfe0c1c99bc55a2827a68d@mail.vulnscan.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bram Matthys wrote on 1-11-2016 11:37:
> I have a Samsung SSD 850 EVO 4TB and under Linux I'm only getting ~240MB/s
> write speed. On Windows it's 490MB/s (yes, without cache).
> The read speed is the same on both Linux and Windows, though. Both are 512MB/s.
>
> Any ideas what this could be? It can't be a slow SATA link as read speed are
> fine. And since write performance is fine on Windows so I'm kinda stunned. Not
> sure how to proceed / debug this any further.
> [..]

I received the following reply from Samsung:
"Unfortunately, there is not much we can assist you with as Samsung does not 
provide support for Linux operating systems."

So that isn't helping much :/

Regards,

Bram
