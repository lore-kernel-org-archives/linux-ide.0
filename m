From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 15:33:46 -0800
Message-ID: <49A5D55A.9080402@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47218 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762542AbZBYXed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 18:34:33 -0500
In-Reply-To: <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
> 
> I'll defer to people like yourself for how this needs to work wrt. boot
> loaders and creating partition tables.  I'm CC:ing Eric Sandeen because
> he's also looking at this...
> 

I wish it was left to people like myself.  Realistically when it comes 
to disks with 4096-byte logical sectors it going to matter how the 
firmware chooses to expose it.

Most likely, the universe will explode at this time, since very few 
bootloaders can deal with a sector size other than 512 bytes, and 
virtually every partition table format contains a sector size 
dependency, which also means you'll break any mechanical imaging solution.

It's going to hurt :(

	-hpa
