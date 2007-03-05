From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil problems with recent kernels
Date: Mon, 05 Mar 2007 13:13:24 +0900
Message-ID: <45EB98E4.9070307@gmail.com>
References: <1172250027.15179.16.camel@dale.velocity.net>	 <1172602444.5420.17.camel@dale.velocity.net> <1172698758.30931.18.camel@dale.velocity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:48887 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbXCEEN0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 23:13:26 -0500
Received: by py-out-1112.google.com with SMTP id a29so790598pyi
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 20:13:25 -0800 (PST)
In-Reply-To: <1172698758.30931.18.camel@dale.velocity.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dale Blount <linux-kernel@dale.us>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Dale Blount wrote:
> On Tue, 2007-02-27 at 13:54 -0500, Dale Blount wrote:
>> On Fri, 2007-02-23 at 12:00 -0500, Dale Blount wrote:
>>> Hi,
>>>
>>> Excuse me if this has been covered or fixed, I couldn't find anything in
>>> the archives.
>>>
>>> I upgraded from 2.6.11.7 to 2.6.20.1 today and found all the drives
>>> connected to 2 brands of sata_sil sata controllers not working.  The
>>> drives are also (now) of various brands, Maxtor 300GB and 500GB
>>> Seagates.
> 
> For the archives, the fix is documented here:
> 
> http://article.gmane.org/gmane.linux.ide/16304

Yeap, that's the correct fix and the problem is introduced in 2.6.20 by
using polling IDENTIFY by default.  Well, the bug has always been there
but no one was issuing polling command to sata_sil upto 2.6.19.

This will probably included in the next -stable iteration.  Thanks.

-- 
tejun
