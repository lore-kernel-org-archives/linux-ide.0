From: linux@horizon.com
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: 2 Nov 2005 13:58:22 -0500
Message-ID: <20051102185822.27745.qmail@science.horizon.com>
References: <20051026191800.28120.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:40500 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965180AbVKBS6d
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 13:58:33 -0500
In-Reply-To: <20051026191800.28120.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, linux@horizon.com

An additional data point: it doesn't appear to have failed "fast", given
that it left the XFS file system in a confused state.
See http://marc.theaimsgroup.com/?l=linux-xfs&m=113081816804458

So while it did lock up and refuse to proceed further, at least one
write got reordered, misdirected, or miswritten as part of the locking-up
procedure.

(Actually, theoretically it could have been a read which returned bad
metadata and led to an incorrect following write, but I would expect
a 150G file system on a 2G machine to have all such core journaling
metadata cached, so there should be on such read.)

As before, thanks for any suggestions or patches.

I'm now attempting to repair the XFS file system and move to a
post-2.6.14 libata kernel.
