From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: confusion about libata.force=80c
Date: Sun, 16 Nov 2008 18:45:43 +0900
Message-ID: <491FEBC7.4090608@kernel.org>
References: <57947bf80805141120v615ef957g323114637d171f0a@mail.gmail.com> <57947bf80805200222j19efa2d2n7ff89fe026745ba1@mail.gmail.com> <4833B9B5.7060601@gmail.com> <loom.20081112T153626-485@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52427 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006AbYKPJpb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 04:45:31 -0500
In-Reply-To: <loom.20081112T153626-485@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Kindl <supp@kpo.zcu.cz>
Cc: linux-ide@vger.kernel.org

Tomas Kindl wrote:
> Tejun Heo <htejun <at> gmail.com> writes:
> 
>>> Is force=80c what I want? Should it work?
>> It should but is overridden by device side cable detection upto 2.6.25. 
>>   2.6.26 will have it fixed.  force=udma66 should work.
>>
> 
> Hi, I get same error (Unknown boot option `libata.force=3:1.5': ignoring
> ) although I am trying it on 2.6.27.4 (MDV flavor - but still).

That's not a kernel problem but how module parameters are passed to
modules loaded from initrd and is distro specific.  Please note that
kernel will spit the message even when the module parameter is later
picked up by initrd.  So, please ping MDV for instructions on how to
pass kernel parameter via initrd.

-- 
tejun
