From: Tejun Heo <tj@kernel.org>
Subject: Re: patch "libata: Add support for SCT Write Same" breaks system
Date: Fri, 9 Sep 2016 11:16:07 -0400
Message-ID: <20160909151607.GA19609@htj.duckdns.org>
References: <20160908192736.GA4356@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34028 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcIIPQJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2016 11:16:09 -0400
Content-Disposition: inline
In-Reply-To: <20160908192736.GA4356@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Krinkin <krinkin.m.u@gmail.com>
Cc: shaun@tancheff.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, hch@lst.de, shaun.tancheff@seagate.com

Hello,

On Thu, Sep 08, 2016 at 10:27:37PM +0300, Mike Krinkin wrote:
> Hi,
> 
> i tried recent linux-next on my laptop, and after boot system is
> almost unusable because most of apps just crash with segfaults and
> in dmesg output there are a lot of errors like this:
...
> git bisect points at commit 7b20309428598df00ffe ("libata: Add support for SCT
> Write Same". I temporary fixed problem with the following change:

Shaun, any ideas?  If this isn't an easy fix, I'm gonna disable
write_same for all devices for now.

Thanks.

-- 
tejun
