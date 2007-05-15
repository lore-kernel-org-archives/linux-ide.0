From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: track spindown status and skip spindown_compat
 if possible
Date: Tue, 15 May 2007 14:17:23 +0200
Message-ID: <4649A4D3.9040808@gmail.com>
References: <46498B82.1030802@gmail.com> <loom.20070515T133840-438@post.gmane.org> <4649A180.1050100@gmail.com> <4649A3AD.8070108@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:35785 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbXEOMSQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 08:18:16 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2126775wra
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 05:18:14 -0700 (PDT)
In-Reply-To: <4649A3AD.8070108@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Francesco Pretto <ceztko@gmail.com>, linux-ide@vger.kernel.org

Stephen Clark wrote:
> Ok, I am running fc6 with kernel.org 2.6.21 what do I need to do to keep
> my laptop from
> popping, and having my retract_count increment, every time I shutdown?

Boot with the updated kernel and shutdown.  If kernel doesn't complain,
you're all set.  If kernel complains, you need to update shutdown(8).
See, easy.  :-)

-- 
tejun
