From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: force disable trim for SuperSSpeed S238
Date: Wed, 15 Jul 2015 11:26:23 -0400
Message-ID: <20150715152623.GB15934@mtj.duckdns.org>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
 <1436961277-4069-3-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32839 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGOP0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 11:26:25 -0400
Received: by ykeo3 with SMTP id o3so39118220yke.0
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2015 08:26:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436961277-4069-3-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: linux-ide@vger.kernel.org

On Wed, Jul 15, 2015 at 01:54:37PM +0200, Arne Fitzenreiter wrote:
> This device loses blocks, often the partition table area, on trim.
> Disable TRIM.
> http://pcengines.ch/msata16a.htm
> 
> Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>

Applied to libata/for-4.2-fixes w/ stable tag added.

Thanks.

-- 
tejun
