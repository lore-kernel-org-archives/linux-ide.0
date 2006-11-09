From: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 9 Nov 2006 12:20:18 +0100
Message-ID: <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:14340 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932805AbWKILUT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 06:20:19 -0500
Received: by wr-out-0506.google.com with SMTP id i5so60805wra
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 03:20:19 -0800 (PST)
In-Reply-To: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jano <jasieczek@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/8/06, Jano <jasieczek@gmail.com> wrote:
> On 8 Lis, 22:50, Jiri Slaby <jirislaby@gmail.com> wrote:
>
> >
> > Which ATA do you use (the prod or experimental)? Post a .config.
> >
>
> .config has been attached. I hope it contains an answer to your
> question, because otherwise I wouldn't know where to search for this
> information.

Aah, sorry for the question, you use 2.6.18.1 and there is no such option yet.

Despite you have ide-generic built-in and other drivers have as a
module and you don't use initrd. If I was you, I'll try to disable
ide-generic and choose your ide chipset as built-in in
ATA/ATAPI/MFM/RLL support under Device drivers.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
