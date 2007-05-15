From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: track spindown status and skip spindown_compat
 if possible
Date: Tue, 15 May 2007 14:03:12 +0200
Message-ID: <4649A180.1050100@gmail.com>
References: <46498B82.1030802@gmail.com> <loom.20070515T133840-438@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:32415 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407AbXEOMDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 08:03:47 -0400
Received: by nz-out-0506.google.com with SMTP id r28so108298nza
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 05:03:46 -0700 (PDT)
In-Reply-To: <loom.20070515T133840-438@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francesco Pretto <ceztko@gmail.com>
Cc: linux-ide@vger.kernel.org

Francesco Pretto wrote:
> Tejun Heo <htejun <at> gmail.com> writes:
>> Our assumption that most distros issue STANDBYNOW seems wrong.  The
>> upstream sysvinit and thus many distros including gentoo and opensuse
>> don't take any action for libata disks on spindown.  We can skip
>> compat handling for these distros so that they don't need to update
>> anything to take advantage of kernel-side shutdown.
>>
> 
> Working around the workaround won't make confusion? Won't this break again
> implementations that was actually issuing STANDBYNOW, assuming that they
> actually exist? Only wondering, can't say for any init implementation in
> particular.

Yeah, it's a big mess.  With this patch applied, what happens is...

* If your shutdown(8) does issue STANDBYNOW : you get the big fat
warning and kernel won't issue STANDBYNOW.

* If your shutdown(8) doesn't issue STANDBYNOW : kernel issues FLUSH
CACHE followed by STANDBYNOW and all is well and dandy without any
userland modification.

I think it isn't too bad.  Any better ideas?

-- 
tejun
