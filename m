From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 09/14] ide: replace remaining __FUNCTION__ occurrences
Date: Tue, 4 Mar 2008 22:25:31 +0100
Message-ID: <200803042225.31306.bzolnier@gmail.com>
References: <ff8fd021606e7a6f03e9c274230cfcf64eade6d2.1204599636.git.harvey.harrison@gmail.com> <1204600190.22933.89.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:18484 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbYCDVTq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 16:19:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2898892ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 13:19:44 -0800 (PST)
In-Reply-To: <1204600190.22933.89.camel@brick>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 04 March 2008, Harvey Harrison wrote:
> __FUNCTION__ is gcc-specific, use __func__
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

applied

[ I fixed checkpatch.pl errors in ide-lib.c and ppc/mpc8xx.c while at it ]
