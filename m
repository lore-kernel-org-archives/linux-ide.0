From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unable to find root fs with libata only 2.6.18-mm3
Date: Sun, 08 Oct 2006 13:08:53 +0900
Message-ID: <452879D5.5020707@gmail.com>
References: <45284BE0.7030600@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:34898 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWJHMqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 08:46:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so1922383pyg
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 05:46:15 -0700 (PDT)
In-Reply-To: <45284BE0.7030600@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ed Sweetman <safemode2@comcast.net>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

Ed Sweetman wrote:
> My question is, do I still need to compile in scsi disk/cdrom/generic 
> support into my kernel to get libata devices to work or is there some 
> other syntax i'm missing?    Libata detects my drives, but as far as I 
> could see, and it flies by too fast to read, no device nodes were 
> assigned to them.

Yes, you do need to select SCSI high level drivers you need - sd and sr 
should suffice for libata.

> If you do need scsi support, why isn't that done automatically when you 
> select your libata drivers? or at least a pointer in the "Help" dialog 
> to tell you to enable that ?

Probably because no other SCSI low level driver selects high level 
driver automatically.  I agree that we need better help message.  Feel 
free to submit patch.

Thanks.

-- 
tejun

