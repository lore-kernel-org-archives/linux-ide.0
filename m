From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 07:17:06 -0800
Message-ID: <49A6B272.2070905@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx> <49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net> <49A5D55A.9080402@zytor.com> <20090226124339.GA10548@nb.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59683 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbZBZPR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 10:17:27 -0500
In-Reply-To: <20090226124339.GA10548@nb.net.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karel Zak <kzak@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Karel Zak wrote:
> On Wed, Feb 25, 2009 at 03:33:46PM -0800, H. Peter Anvin wrote:
>> virtually every partition table format contains a sector size  
>> dependency
> 
>  Is it true that "every partition table format"? I see in
>  fs/partitions/ that only ibm.c and msdos.c care about a sector size.
>  It seems that the others formats are based on 512 sectors only.
> 

And do they do so correctly?

Looking at the UEFI spec for one, the GPT partition table format
definitely has a logical sector size dependency.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

