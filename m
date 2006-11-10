From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Fri, 10 Nov 2006 21:36:47 +0100
Message-ID: <4554E2DF.2020102@gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>	 <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>	 <45537B67.6050804@gmail.com> <d9a083460611100739v531b0293i5ae5fd8d3ccee800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:12232 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966112AbWKJUiK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 15:38:10 -0500
In-Reply-To: <d9a083460611100739v531b0293i5ae5fd8d3ccee800@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jano <jasieczek@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jano wrote:
> 2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
>>
>> In such cases google is very helpful ;).
>>
> 
> Sorry, my mistake :D.
> 
>>
>> No, I meant strace(1):
>> strace mount /dev/hdbX /home
>>
> 
> # strace mount /dev/hdb1 > file1
> # strace mount /home > file2

yeah. Either redirect stderr by 2> file1 (this will contain mount errors too) or
use strace -o file1

[snip]
>> And try to turn "VIA82CXXX chipset support" to <*>, i.e. built-in
>> (somebody
>> holds regions of ide0 and ide1, let's try via driver to probe first).
>>
> 
> Also done. Haven't changed anything.
> 
> Hope that strace output will be helpful. As far as I'll be able to
> save the results. Any suggestions?

When you boot with init=/bin/bash not to allow system to start scripts, does it
work? (add init=/bin/bash kernel parameter)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
