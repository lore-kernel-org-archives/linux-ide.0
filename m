From: Luca <kronos.it@gmail.com>
Subject: Re: Hitachi disk: spurious completions during NCQ
Date: Mon, 15 Oct 2007 11:47:20 +0200
Message-ID: <68676e00710150247s23d06db2sdb17af6fafdc4b77@mail.gmail.com>
References: <9cP6K-6rV-29@gated-at.bofh.it> <87zlyksyfc.fsf@meer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:42277 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198AbXJOJrX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 05:47:23 -0400
Received: by nz-out-0506.google.com with SMTP id s18so851501nze
        for <linux-ide@vger.kernel.org>; Mon, 15 Oct 2007 02:47:22 -0700 (PDT)
In-Reply-To: <87zlyksyfc.fsf@meer.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 10/15/07, Don Mullis <dwm@meer.net> wrote:
>
> > ata3.00: spurious completions during NCQ issue=0x0 SAct=0x407fd FIS=005040a1:00020000
> > ata3.00: cmd 61/08:00:c7:5a:82/00:00:1b:00:00/40 tag 0 cdb 0x0 data 4096 out
> >          res 50/00:10:07:5b:82/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
>
>
> This has been seen with several Hitachi drives.  There's speculation
> that it's due to a bug in the drive firmware:

Yes, I'm aware of this. That's why I was suggesting to blacklist this drive.

thanks,
Luca
