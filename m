From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Tue, 01 Mar 2005 14:29:32 +0900
Message-ID: <4223FDBC.8080504@gmail.com>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <200502271731.29448.bzolnier@elka.pw.edu.pl> <422337A1.4060806@gmail.com> <200502281714.55960.bzolnier@elka.pw.edu.pl> <20050301042116.GA9001@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:52629 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261243AbVCAF3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2005 00:29:38 -0500
Received: by wproxy.gmail.com with SMTP id 68so1105735wri
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 21:29:37 -0800 (PST)
In-Reply-To: <20050301042116.GA9001@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


  Oh, Bartlomiej, one more thing.

  If it isn't too much trouble, can you please set up a bk repository 
which contains the patches you've posted and whatever you're working on 
but hasn't yet made into ide-dev tree?  So that we don't have to juggle 
patches back and forth.  If you maintain your up-to-date working tree, 
I'll make my patches against that tree and if it's convinient for you, I 
can also set up an export tree you can pull from.

  Thanks.  :-)

-- 
tejun

