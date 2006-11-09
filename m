From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 09 Nov 2006 18:47:53 +0100
Message-ID: <455369C9.7020909@gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com> <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com> <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com> <455360CF.9070600@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:31911 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1424172AbWKIRsA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 12:48:00 -0500
In-Reply-To: <455360CF.9070600@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jano <jasieczek@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Phillip Susi wrote:
> Jiri Slaby wrote:
>> Phillip: please, so not top-post
> 
> Please stop discouraging top posting.  There is no reason to have to
> scroll down through a screen or two of quoted message that you  just
> read the original of, before getting to the new subject matter.

Nope.
http://www.zipworld.com.au/~akpm/linux/patches/stuff/top-posting.txt

> <snip>
>> There is a proc/mounts here:
>> http://lkml.org/lkml/2006/11/08/322
>>
> 
> I didn't ask for /proc/mounts, I asked for the output of the mount
> command with no arguments, which prints the contents of /etc/mtab.  I
> was thinking that /etc/mtab might show the partitions as mounted even
> though they are not, which could be why mount is complaining.

Mount(8) calls mount(2) no matter what is in the /etc/mtab.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
