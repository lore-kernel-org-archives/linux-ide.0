From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Wed, 25 Feb 2009 10:44:13 +0100
Message-ID: <49A512ED.9080706@wpkg.org>
References: <49A30901.1@wpkg.org> <49A3F63A.2080805@rtr.ca> <49A43E73.6070705@wpkg.org> <49A4771F.5060802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx03.syneticon.net ([78.111.66.105]:44595 "EHLO
	mx03.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBYJnu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 04:43:50 -0500
In-Reply-To: <49A4771F.5060802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord schrieb:

> Everything looks configured correctly, so the only explanations
> for the slow (10/20MB/sec) speeds are the CPU/RAM, or other system 
> activity.

It's a pretty powerful machine with plenty of RAM, no other activity.


> As for the disparity in initial throughput between the master/slave drives,
> you could try reversing the two drives (swap them on the cable if using
> "cable select", otherwise rejumper the master/slave setup).  Then see if 
> the
> slow start follows the specific drive to its new position on the cable,
> or if the master ("a") drive is always slower.

Yes, "reversing" the drives makes the master slower (at least initially).

Controller's "feature"?


-- 
Tomasz Chmielewski
http://wpkg.org
