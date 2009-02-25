From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 14:53:43 -0800
Message-ID: <49A5CBF7.9000501@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56767 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZBYWxu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 17:53:50 -0500
In-Reply-To: <1235600698-6446-1-git-send-email-matthew@wil.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> The two patches following this add support for drives which have sector
> sizes other than 512 bytes.  I haven't been able to test this as I don't
> have the hardware.
> 
> Individual host drivers will have to be updated to support sizes other
> than 512 bytes.
> 
> Support for logical sector sizes that differ from physical sector sizes
> depends on the READ CAPACITY 16 patch I posted in December that isn't in
> scsi-misc yet.
> 
> The approach I've taken to generating the tables of which commands need
> a 512-byte transfer size and which use the drive's sector size command is
> 'innovative'.  Review is encouraged ;-)

What sector size do we report to user space for this?  I'm asking 
because logical sector size is visible in most partition formats.

	-hpa
