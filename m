From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 15:42:34 -0800
Message-ID: <49A5D76A.3010301@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60635 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZBYXoB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 18:44:01 -0500
In-Reply-To: <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
> 
> Because of 63-sector legacy problems a bunch of ATA vendors will
> initially ship 512/4096 drives that are not naturally aligned.
> I.e. logical sector 63 will be aligned on a 4KB hardware sector
> boundary to overcome the misaligned default partitioning.
> 

I was under the impression Vista didn't do this?  Is there any way to 
force these drives into a sane mode (at the expense of a total data loss)?

	-hpa
