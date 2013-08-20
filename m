From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata: fsl: save irqs while coalescing
Date: Tue, 20 Aug 2013 08:39:36 -0400
Message-ID: <20130820123936.GD3926@htj.dyndns.org>
References: <gsiy6olhp.fsf@dworkin.scrye.com>
 <1376961630-6255-1-git-send-email-anthony.foiani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33333 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3HTMjk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Aug 2013 08:39:40 -0400
Received: by mail-qc0-f174.google.com with SMTP id c1so158108qcz.5
        for <linux-ide@vger.kernel.org>; Tue, 20 Aug 2013 05:39:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376961630-6255-1-git-send-email-anthony.foiani@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anthony Foiani <anthony.foiani@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, Bhushan Bharat-R65777 <R65777@freescale.com>, Anthony Foiani <tkil@scrye.com>, Scott Wood <scottwood@freescale.com>

On Mon, Aug 19, 2013 at 07:20:30PM -0600, Anthony Foiani wrote:
> This patch is based off linux-next tag next-20130819
> (which is commit 66a01bae29d11916c09f9f5a937cafe7d402e4a5 )
> 
> Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>

Applied to libata/for-3.11-fixes w/ stable cc'd.

Thanks.

-- 
tejun
