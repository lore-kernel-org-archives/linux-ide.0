From: Karel Zak <kzak@redhat.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 13:43:39 +0100
Message-ID: <20090226124339.GA10548@nb.net.home>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx> <49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net> <49A5D55A.9080402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:46753 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbZBZMnt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Feb 2009 07:43:49 -0500
Content-Disposition: inline
In-Reply-To: <49A5D55A.9080402@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

On Wed, Feb 25, 2009 at 03:33:46PM -0800, H. Peter Anvin wrote:
> virtually every partition table format contains a sector size  
> dependency

 Is it true that "every partition table format"? I see in
 fs/partitions/ that only ibm.c and msdos.c care about a sector size.
 It seems that the others formats are based on 512 sectors only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
