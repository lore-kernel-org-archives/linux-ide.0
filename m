From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_samsung_cf: change ret type to signed
Date: Sat, 16 Aug 2014 09:11:15 -0400
Message-ID: <20140816131115.GJ9305@htj.dyndns.org>
References: <1408194514-2001-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:47640 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaHPNLS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2014 09:11:18 -0400
Content-Disposition: inline
In-Reply-To: <1408194514-2001-1-git-send-email-arjun024@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 16, 2014 at 06:38:34PM +0530, Arjun Sreedharan wrote:
> Change return type to signed int since it could be
> a negative errno.
> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>

Applied to libata/for-3.17-fixes.

Thanks.

-- 
tejun
