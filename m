From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix: ICH7 "invalid MAP value 0" msg at boot
Date: Fri, 26 Oct 2007 11:10:21 +0900
Message-ID: <47214C8D.9000706@gmail.com>
References: <20071015171444.GA9512@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:50573 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705AbXJZCK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 22:10:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so844507wah
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 19:10:28 -0700 (PDT)
In-Reply-To: <20071015171444.GA9512@vaio>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guilherme Amadio <guilherme.amadio@gmail.com>
Cc: linux-ide@vger.kernel.org

Guilherme Amadio wrote:
>  Hello,
> 
>  I have a Sony laptop SZ series and I get the message
>  
>  ata_piix 0000:00:1f.2: invalid MAP value 0
> 
>  even with 'quiet' in the boot command line. I think it's because of a controller
>  with no disk attached, but I am a total newb, so I went to #kernelnewbies and 
>  I was told to post this here. The code that prints the message is here
>  drivers/ata/ata_piix.c +973. 
>  
>  I'm using this kernel:
>  Linux vaio 2.6.22-gentoo-r8 #1 SMP PREEMPT Sun Sep 30 13:19:56 BRT 2007
>  i686 Genuine Intel(R) CPU T2400 @ 1.83GHz GenuineIntel GNU/Linux
> 
>  Below are the outputs that may be relevant for tracing the problem.
>  If anything else is needed, I can provide, but please CC me, because I'm
>  not subscribed to the list.

Please try 2.6.23.  It should have been fixed.  The message can be
safely ignored BTW.

-- 
tejun
