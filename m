From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: Update queued trim blacklist for M5x0 drives
Date: Wed, 2 Apr 2014 13:11:00 -0400
Message-ID: <20140402171100.GI16631@htj.dyndns.org>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
 <1396399357-28388-2-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:64749 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932550AbaDBRLD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2014 13:11:03 -0400
Received: by mail-qg0-f51.google.com with SMTP id q108so499932qgd.24
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2014 10:11:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1396399357-28388-2-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

On Tue, Apr 01, 2014 at 08:42:37PM -0400, Martin K. Petersen wrote:
> From: "Martin K. Petersen" <martin.petersen@oracle.com>
> 
> Crucial/Micron M500 drives properly support queued DSM TRIM starting
> with firmware MU05. Update the blacklist so we only disable queued trim
> for older firmware releases.
> 
> Early M550 series drives suffer from the same issue as M500. A bugfix
> firmware is in the pipeline but not ready yet. Until then, blacklist
> queued trim for M550.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Chris Samuel <chris@csamuel.org>
> Cc: Marc MERLIN <marc@merlins.org>

Cool, applied to libata/for-3.15-fixes w/ stable cc'd.

Thanks!

-- 
tejun
