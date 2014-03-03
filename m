From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: disable queued TRIM for Crucial M500 mSATA SSDs
Date: Mon, 3 Mar 2014 17:51:59 -0500
Message-ID: <20140303225159.GG26523@mtj.dyndns.org>
References: <9306023.Q3rnH2c0bQ@miles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:44614 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbaCCWwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2014 17:52:03 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so4187877qac.27
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2014 14:52:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9306023.Q3rnH2c0bQ@miles>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marios Andreopoulos <opensource@andmarios.com>
Cc: linux-ide@vger.kernel.org

On Mon, Mar 03, 2014 at 06:19:59PM +0200, Marios Andreopoulos wrote:
> From: Marios Andreopoulos <opensource@andmarios.com>
> 
> Queued TRIM commands cause problems and silent file system corruption
> on Crucial M500 SSDs. This patch disables them for the mSATA model of
> the drive.
> 
> Signed-off-by: Marios Andreopoulos <opensource@andmarios.com>

Applied to libata/for-3.14-fixes w/ stable cc'd.

Thanks.

-- 
tejun
