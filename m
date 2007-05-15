From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Tue, 15 May 2007 12:42:07 +0200
Message-ID: <46498E7F.6040201@gmail.com>
References: <46492931.4080700@gentoo.org> <46496D47.9010504@gmail.com> <loom.20070515T122357-890@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:52144 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbXEOKm0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 06:42:26 -0400
Received: by nz-out-0506.google.com with SMTP id r28so85873nza
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 03:42:25 -0700 (PDT)
In-Reply-To: <loom.20070515T122357-890@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francesco Pretto <ceztko@gmail.com>
Cc: linux-ide@vger.kernel.org

Francesco Pretto wrote:
> Tejun Heo <htejun <at> gmail.com> writes:
>>> Final question: should spindown_compat be set to 0 for both shutdown and
>>> reboot, or just shutdown?
>> It doesn't really matter.  It just needs to be set while powering down.
>>  You can set it anywhere, during boot, in shutdown.
>>
>> Thanks.
>>
> 
> Hibernate/suspend shall be also considered. Setting it during boot it's one time
> for every poweroff conditions, but i can't say if it's the best approach.

The compat thing is only for shutdown/powerdown.  Kernel will always
flush and spindown disks on suspends.  So, really, it doesn't matter
when you set the variable.

-- 
tejun
