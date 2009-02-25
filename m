From: Mark Lord <liml@rtr.ca>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Wed, 25 Feb 2009 11:26:57 -0500
Message-ID: <49A57151.1060206@rtr.ca>
References: <49A30901.1@wpkg.org> <49A3F63A.2080805@rtr.ca> <49A43E73.6070705@wpkg.org> <49A4771F.5060802@rtr.ca> <49A512ED.9080706@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46332 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760929AbZBYQ1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 11:27:00 -0500
In-Reply-To: <49A512ED.9080706@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-ide@vger.kernel.org

Tomasz Chmielewski wrote:
> Mark Lord schrieb:
> 
>> Everything looks configured correctly, so the only explanations
>> for the slow (10/20MB/sec) speeds are the CPU/RAM, or other system 
>> activity.
> 
> It's a pretty powerful machine with plenty of RAM, no other activity.
> 
> 
>> As for the disparity in initial throughput between the master/slave 
>> drives,
>> you could try reversing the two drives (swap them on the cable if using
>> "cable select", otherwise rejumper the master/slave setup).  Then see 
>> if the
>> slow start follows the specific drive to its new position on the cable,
>> or if the master ("a") drive is always slower.
> 
> Yes, "reversing" the drives makes the master slower (at least initially).
> 
> Controller's "feature"?
..

Kinda looks that way.  Perhaps the driver isn't setting the master device
up with optimal settings somewhere.. FIFO sizes or something ??

Maybe somebody more familiar with serverworks stuff could have a look now.

