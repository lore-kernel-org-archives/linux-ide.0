From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 16:10:31 -0800
Message-ID: <49A5DDF7.9070301@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>	<49A5D76A.3010301@zytor.com> <yq11vtmhy0x.fsf@sermon.lab.mkp.net>	<49A5DAE7.3060409@zytor.com> <yq1skm2giwa.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55306 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbZBZAKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 19:10:52 -0500
In-Reply-To: <yq1skm2giwa.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
> 
> hpa> Why one-time?
> 
> It's a compromise to avoid hours of low-level formatting before you can
> use a drive.  New drives will come from the factory formatted in a
> special way that can be switched instantaneously.  But once you start
> writing you're stuck with it.
> 

That's ridiculously stupid.  All you need is an offset parameter, which 
can be flipped at will.  Now, flipping it will obviously scramble all 
data, but there is absolutely no reason why it shouldn't be possible to 
instantaneously flip it back and forth.

	-hpa
