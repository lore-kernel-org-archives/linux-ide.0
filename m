From: Tejun Heo <htejun@gmail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under
 kernel 2.6.18
Date: Sun, 08 Oct 2006 13:33:42 +0900
Message-ID: <45287FA6.5020906@gmail.com>
References: <op.tg1yx12kxci36i@akima>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48729 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWJHMqX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 08:46:23 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1658581nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 05:46:22 -0700 (PDT)
In-Reply-To: <op.tg1yx12kxci36i@akima>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Jonathan Bell wrote:
> The problem is that when copying a file off one drive on the controller to
> another on the same controller, be it via dd or cp, the file that gets
> written becomes corrupted along with the filesystem itself. Here is an
> extract from dmesg:

That's very weird.

> [12689.451466] attempt to access beyond end of device
> [12689.451475] sdb1: rw=0, want=2339438600, limit=488392002
> [12689.451480] attempt to access beyond end of device
> [12689.451484] sdb1: rw=0, want=18446744056529747976, limit=488392002
> [12689.453822] attempt to access beyond end of device
> [12689.453831] sdb1: rw=0, want=2339438600, limit=488392002
> [12689.453834] Buffer I/O error on device sdb1, logical block 292429824
> [12689.453935] attempt to access beyond end of device
> [12689.453938] sdb1: rw=0, want=2339438600, limit=488392002
> [12689.453941] Buffer I/O error on device sdb1, logical block 292429824
[--snip--]
> I would like some help tracking down the cause of this problem as I have
> practically exhausted the methods currently at my disposal - my best guess
> at the moment is that data being written to another port is being trampled
> on somehow but only when there is I/O active on another port. I will
> continue testing to see if simultaneous writes to multiple drives on a
> controller causes the same problem.

Can you repeat the test using raw devices - /dev/sdX?  I don't think 
filesystem is at fault, so let's rule it out.  Also, please post the 
result of lspci -nvvvxxx

Thanks.

-- 
tejun

