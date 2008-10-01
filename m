From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloads  info
Date: Wed, 01 Oct 2008 10:42:15 +0900
Message-ID: <48E2D577.90801@kernel.org>
References: <op.uhjrgs2b70fqr1@blacktop> <48E08401.6060808@kernel.org> <op.uh9nv6gs70fqr1@blacktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34405 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbYJABnx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 21:43:53 -0400
In-Reply-To: <op.uh9nv6gs70fqr1@blacktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Vaselaar <andrew.vaselaar@trinity.edu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

(restoring linux-ide and copying whole body for reference)

Andy Vaselaar wrote:
> Looks like it goes about 2-3 times a minute:
> 
> [root@blacktop andy]# smartctl -a /dev/sda | grep 193
> 193 Load_Cycle_Count        0x0032   012   012   000    Old_age  
> Always       -       177144
> [root@blacktop andy]# sleep 60 ; smartctl -a /dev/sda | grep 193
> 
> 193 Load_Cycle_Count        0x0032   012   012   000    Old_age  
> Always       -       177147
> 
> 
> I just did that, and as of right now, its at 177152.  So, 120-180 times
> an hour.
> 
> -Andy
> 
> 
> 
> On Mon, 29 Sep 2008 02:30:09 -0500, Tejun Heo <tj@kernel.org> wrote:
> 
>> Andy Vaselaar wrote:
>>>
>>> hdparm -B255 /dev/sda
>>>
>>> seems to stop it from unloading the heads.
>>
>> How much does the load_cycle_count increase per hour without the
>> adjustment?
>>
>> Thanks.
>>
> 


-- 
tejun
