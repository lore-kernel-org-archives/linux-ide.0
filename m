From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 15:57:27 -0800
Message-ID: <49A5DAE7.3060409@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>	<49A5D76A.3010301@zytor.com> <yq11vtmhy0x.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35393 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759641AbZBYX5q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 18:57:46 -0500
In-Reply-To: <yq11vtmhy0x.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
> 
> Modern Windows aligns the first partition on a 1 MB boundary.
> 
> As far as disks go, initially the plan was to have "legacy" branded
> drives with 63-sector alignment.  But I think that has been abandoned in
> favor of instant one-time formatting.  I.e. you can pick your poison
> *once* and that formatting will be done in constant time.  Any
> subsequent changes to blocking and alignment will require a real
> low-level format.
> 

Why one-time?

	-hpa
