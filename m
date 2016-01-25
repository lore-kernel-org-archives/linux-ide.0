From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v2] drivers: libata-core : blacklist a Viking flash
 model for MWDMA corruption
Date: Mon, 25 Jan 2016 15:24:47 -0500
Message-ID: <20160125202447.GL3628@mtj.duckdns.org>
References: <1452552945-13609-1-git-send-email-danielwa@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34338 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbcAYUYt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 15:24:49 -0500
Content-Disposition: inline
In-Reply-To: <1452552945-13609-1-git-send-email-danielwa@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Walker <danielwa@cisco.com>
Cc: Chris Hall <hall@cisco.com>, Shikha Jain <shikjain@cisco.com>, xe-kernel@external.cisco.com, Anil Veliyankara Madam <aveliyan@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 11, 2016 at 02:55:45PM -0800, Daniel Walker wrote:
> From: Shikha Jain <shikjain@cisco.com>
> 
> Viking flash model VRFDFC22048UCHC-TE causes data corruption in MWDMA mode.
> 
> Cc: xe-kernel@external.cisco.com
> Signed-off-by: Shikha Jain <shikjain@cisco.com>
> Signed-off-by: Anil Veliyankara Madam <aveliyan@cisco.com>

Applied to libata/for-4.5-fixes.

Thanks.

-- 
tejun
