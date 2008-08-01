From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140,
 simg 3726
Date: Fri, 01 Aug 2008 11:05:50 +0900
Message-ID: <48926F7E.1020807@kernel.org>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org> <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32832 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbYHACHA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 22:07:00 -0400
In-Reply-To: <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

KueiHuan Chen wrote:
>   Thanks your reply Tejun, i would try it  ^__^.
> 
>   Before that, Could i ask a question that had you ever try to using
> port multiplier(sil 3726 or marvel 4140) with 6121/6145
> succefully(with ahci.c) ?

Eh.. another mistake by me.  I was talking about controllers supported
by sata_mv.  Mark Lord worked on it and added PMP support.  AFAIK PMP
support on 6145/6121 is yet to arrive.  Right, Mark?

Thanks.

-- 
tejun
