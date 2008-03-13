From: Richard Scobie <richard@sauce.co.nz>
Subject: Re: Useful benchmarking tools for RAID
Date: Fri, 14 Mar 2008 10:14:16 +1300
Message-ID: <47D99928.9010200@sauce.co.nz>
References: <1205360878.30451.134.camel@atlantis.cc.ndsu.nodak.edu> <18393.37268.150207.688089@tree.ty.sabi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:42626 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbYCMVTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Mar 2008 17:19:42 -0400
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 85501288265
	for <linux-ide@vger.kernel.org>; Fri, 14 Mar 2008 10:12:18 +1300 (NZDT)
In-Reply-To: <18393.37268.150207.688089@tree.ty.sabi.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Peter Grandi wrote:

> for example. XFS also has the advantages that it supports write
> barriers (but not sure if the one in 2.6.18 already does), so you
> could probably enable the host adapter cache, and that it handles
> well very parallel access patterns. It has the disadvantage that
> it can require several GB of memory to 'fsck' (like 1GB per 1TB
> of filesystem, or more), and does not work as well with lots of
> small files (while ReiserFS is very good, and JFS not too bad).

This no longer need be the case, (xfs_repair memory usage).

Improvements were made in xfs_repair 2.9.2 and later - quoting one of 
the develpoers:

"Right now, I can repair a 9TB filesystem with ~150 million inodes
in 2GB of RAM without going to swap using xfs_repair 2.9.4 and
with no custom/tuning/config options."

Regards,

Richard
