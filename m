From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Add factory recertified Crucial M500s to blacklist
Date: Wed, 26 Aug 2015 11:32:11 -0400
Message-ID: <20150826153211.GG26785@mtj.duckdns.org>
References: <1440570553-1600-1-git-send-email-g@maral.me>
 <1440570553-1600-2-git-send-email-g@maral.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32794 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbbHZPcO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 11:32:14 -0400
Received: by ykll84 with SMTP id l84so190337480ykl.0
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2015 08:32:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440570553-1600-2-git-send-email-g@maral.me>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Guillermo A. Amaral" <g@maral.me>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 25, 2015 at 11:29:13PM -0700, Guillermo A. Amaral wrote:
> The Crucial M500 is known to have issues with queued TRIM commands, the
> factory recertified SSDs use a different model number naming convention
> which causes them to get ignored by the blacklist.
> 
> The new naming convention boils down to: s/Crucial_/FC/
> 
> Signed-off-by: Guillermo A. Amaral <g@maral.me>

Applied to libata/for-4.2-fixes w/ stable cc'd.

Thanks.

-- 
tejun
