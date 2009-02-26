From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 07:32:20 -0800
Message-ID: <49A6B604.1060702@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>	<20090226025043.GJ1363@mit.edu>	<20090226030735.GA16891@parisc-linux.org> <yq1eixlg4mn.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45564 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbZBZPdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 10:33:47 -0500
In-Reply-To: <yq1eixlg4mn.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
> 
> Quick answer from one of my contacts.  Desktop drives will indeed ship
> with an alignment of 1(*).  The alignment is hardwired at time of
> manufacture and can't be changed.
> 

Oh God.

This is a disaster.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

