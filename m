From: Tejun Heo <tj@kernel.org>
Subject: Re: Candidate for late revert ?
Date: Mon, 2 Jun 2014 21:15:10 -0400
Message-ID: <20140603011510.GD19855@htj.dyndns.org>
References: <20140603000728.28fca8fe@www.etchedpixels.co.uk>
 <CA+55aFykTbMRKku1bDd_wHCjyD+Yf2v-B8-c+NKMZ0AnNkpVrw@mail.gmail.com>
 <yq138fm98in.fsf@sermon.lab.mkp.net>
 <20140603004520.GB19855@htj.dyndns.org>
 <yq1sinm6bl3.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:57011 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbaFCBPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2014 21:15:14 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so12001559qgz.16
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2014 18:15:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <yq1sinm6bl3.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello,

On Mon, Jun 02, 2014 at 09:11:52PM -0400, Martin K. Petersen wrote:
> OK. And how do you feel about making a disable/unqueued/queued sysfs
> knob? I'd really like to make it easy for the drive vendors to test. And
> if we liberally blacklist their firmware releases then we have
> significantly raised the barrier for their testing. Because all of a
> sudden they need to start mucking with kernel builds instead of booting
> the latest $DISTRO Live CD.

I have no problem with adding debug features as long as it's clear
that it's a debug feature - please gate it with a module param which
clearly indicates that it's for debugging.

Thanks.

-- 
tejun
