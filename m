From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 22:23:25 -0500
Message-ID: <yq1myc9g9ua.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<20090226025043.GJ1363@mit.edu>
	<20090226030735.GA16891@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet13.oracle.com ([148.87.113.125]:51089 "EHLO
	rgminet13.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZBZDYb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 22:24:31 -0500
In-Reply-To: <20090226030735.GA16891@parisc-linux.org> (Matthew Wilcox's message of "Wed\, 25 Feb 2009 20\:07\:35 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Theodore Tso <tytso@mit.edu>, "Martin K. Petersen" <martin.petersen@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> Lowest aligned logical block address=0

Matthew> This disagrees with Martin's assertion.

The original roadmap was to transition to 4KB sectors in 2006,
coinciding with the Vista release.

Given how long this has taken (we're now talking ~2011 for GA) it may
very well be that the alignment knobs will be unused because everybody
will be using Vista or 7 by then.

That doesn't change the RAID array alignment problem, however.  And we
need to prepare our partitioning tools to align correctly regardless.

-- 
Martin K. Petersen	Oracle Linux Engineering
