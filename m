From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Tue, 7 Apr 2009 20:10:33 +0200
Message-ID: <20090407181033.GA2673@gentoox2.trippelsdorf.de>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com> <49DB8B54.7050402@garzik.org> <49DB9422.5040702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760341AbZDGSKs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49DB9422.5040702@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <willy@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Woodhouse <David.Woodhouse@intel.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 07, 2009 at 01:57:54PM -0400, Mark Lord wrote:
> Are there any commercially available SSDs that have this feature yet?
> Anyone know which ones?

OCZ will release a new firmware for their Vertex line in the coming
days, which will feature ATA TRIM support.
And since they get their firmware directly from Indilinx, all SSDs
with this controller will be TRIM ready in the future.

http://www.ocztechnologyforum.com/forum/showthread.php?t=54373

-- 
Markus
