From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 09 Nov 2006 18:01:55 +0100
Message-ID: <45535F03.8020105@gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com> <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:16265 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1424132AbWKIRCM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 12:02:12 -0500
In-Reply-To: <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jano <jasieczek@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jano wrote:
>> Phillip Susi wrote:
>> > Ubuntu uses an initramfs, so unless he has rebuilt his kernel to get
>> > around that, he should still be using one.
>>
> 
> I've compiled it into the kernel, but it doesn't work.

But I guess, you either haven't mkinitrd'ed it or you don't have an initrd line
in your loader config (I can't see any difference in dmesgs diff)?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
