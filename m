From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Date: Tue, 01 Aug 2006 16:32:27 +0900
Message-ID: <44CF038B.50809@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net>	<44CD0E55.4020206@gmail.com>	<20060731172452.76a1b6bd@werewolf.auna.net>	<44CE2908.8080502@gmail.com>	<1154363489.7230.61.camel@localhost.localdomain>	<20060731165011.GA6659@htj.dyndns.org> <20060731232243.65468eec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:58604 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161323AbWHAHcR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 03:32:17 -0400
Received: by py-out-1112.google.com with SMTP id t32so1038975pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 00:32:16 -0700 (PDT)
In-Reply-To: <20060731232243.65468eec.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, jamagallon@ono.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Andrew Morton wrote:
> On Tue, 1 Aug 2006 01:50:11 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>>> It'll be easier just to work outside the -mm tree with all this
>>> continued in/out random breakage if people are just going to say "drop
>>> xyz patch" rather than actually specifying *what is actually wrong* and
>>> getting me to fix the merge (Tejun that last one sentence is a hint ;))
>> Okay, took the hint.  Magallon, can you please try the following
>> patch?
> 
> Gee that's a big scary patch.  Is it considered ready for -mm?  (bearing in
> mind -mm's exacting quality standards (heh, I kill me)).
> 

It's still a bit broken.  I'll follow up with better patches later today 
(hopefully :)

Thanks.

-- 
tejun
