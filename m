From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA timeout value
Date: Tue, 24 Apr 2007 17:25:51 +0900
Message-ID: <462DBF0F.1080903@gmail.com>
References: <32623559.31421177346818776.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:43934 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031049AbXDXIZ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 04:25:58 -0400
Received: by nz-out-0506.google.com with SMTP id o1so358306nzf
        for <linux-ide@vger.kernel.org>; Tue, 24 Apr 2007 01:25:57 -0700 (PDT)
In-Reply-To: <32623559.31421177346818776.JavaMail.servlet@perfora>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Sloan <russell.sloan@lingua-data.com>
Cc: linux-ide@vger.kernel.org

Russell Sloan wrote:
> Yes, it looks like it's trying very hard to talk to the drive (which
> is a good thing under normal circumstances), but the drive isn't
> there anymore.  It's SATA hardware is powered down at this point.  It
> doesn't sound like the right way of doing things, but it's the
> behavior of the drive I'm working with.
> 
> I actually have a 5-disk RAID that I'm working with, 3 connected
> directly to a SiI 3124 and two behind a 4726 PMP.  The messages for
> the 3 direct connects are the same.  I see similar activity for the 3
> PMP drives.
> 
> Attached is a text file with a complete listing of the activity for
> each of the 5 drives after the command is issued to each.

Ah, right.  After the timeout, libata error handling kicks in and tries
to verify that the drive is there and working.  As the device is
completely unresponsive, it takes some time before libata EH to give up
the device.  I honestly don't know how to solve this.  :-(

-- 
tejun
