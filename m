From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support
Date: Sun, 15 Oct 2006 14:47:14 +0900
Message-ID: <4531CB62.1000609@gmail.com>
References: <11607058883329-git-send-email-htejun@gmail.com> <1160844586.3040.6.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:21840 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751780AbWJOFrY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 01:47:24 -0400
Received: by nf-out-0910.google.com with SMTP id c2so451089nfe
        for <linux-ide@vger.kernel.org>; Sat, 14 Oct 2006 22:47:23 -0700 (PDT)
In-Reply-To: <1160844586.3040.6.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aalderd.boac@wanadoo.nl
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Aalderd Bouwman wrote:
[--snip--]
> As you see it works!!

Glad to hear that. :-)

> Only you found FAILED by synchronizing the SCSI cache for disk sdb.
> Is that a problem or did I forget anything?

No, that's normal.  The device is already gone when the sd layer tries 
cache sync, so the behavior is expected.

> Tejun: Did you also make NCQ working?

Well, I gave it a shot and ended up w/ corrupt root fs.  I don't think 
I'll try it again till I have more info.

Thanks.

-- 
tejun
