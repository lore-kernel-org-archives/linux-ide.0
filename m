From: Gavin Cameron <gavin@gavsworld.net>
Subject: Re: Frequent Head Unload Problem
Date: Thu, 23 Apr 2009 23:00:18 +0100
Message-ID: <49F0E4F2.9000400@gavsworld.net>
References: <49E4BF3E.9040105@gavsworld.net> <49E537F4.8000807@gmail.com> <49E666B2.6090708@gavsworld.net> <49E67576.8070704@gmail.com> <49E8C14D.7020907@gavsworld.net> <49E92BDF.7060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:5307 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755429AbZDWWAV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 18:00:21 -0400
In-Reply-To: <49E92BDF.7060507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Gavin Cameron wrote:
>> What do you think? Just a knackered drive and nothing to do with 
>> libata at all?
> 
> Yeah, it's possible that what you're hearing isn't a head unload at all, 
> but some kind of abnormal recalibration noise, etc.

Hi again,

Just to follow up on this. I installed a new hard drive yesterday and 
magically this horrible sounding noise has stopped. So, it looks like 
the hard drive was doing that on it's own - as you say, perhaps a 
re-calibration cycle due to the excessive CRC errors.

Anyway, sorry for wild goose chase, but many, many thanks for pointing 
me down the path that made me discover that my /home partition didn't 
have long to live. I managed to transfer all data over sucessfully :-)

Best regards,
Gavin.
