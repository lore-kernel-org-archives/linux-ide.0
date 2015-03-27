From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/9] libata sense code update
Date: Fri, 27 Mar 2015 12:01:10 -0400
Message-ID: <20150327160110.GA638@htj.duckdns.org>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36296 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbbC0QBO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Mar 2015 12:01:14 -0400
Content-Disposition: inline
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 27, 2015 at 04:46:29PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> with ACS-4 ATA drives inherited the possibility to return
> SCSI sense codes, allowing for a more precise error handling.
> Not to mention a nice alignment with the SCSI error handling.
> This patchset implements both, support for NCQ Autosense and
> the sense data reporting feature set.
> Plus some whitespace and assorted cleanups.
> And I've added some tracepoints, too.

Applied 1-9 to libata/for-4.1.

Thanks a lot for the excellent patchset.

-- 
tejun
