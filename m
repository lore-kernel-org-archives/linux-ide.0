From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata:Check if D2H Register FIS command fails in the
 function ahci_do_softreset
Date: Mon, 21 Sep 2015 15:02:51 -0400
Message-ID: <20150921190251.GE13263@mtj.duckdns.org>
References: <1442630182-25614-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34116 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbIUTCz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Sep 2015 15:02:55 -0400
Content-Disposition: inline
In-Reply-To: <1442630182-25614-1-git-send-email-xerofoify@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 18, 2015 at 10:36:22PM -0400, Nicholas Krause wrote:
> This fixes the missing error check and handling if the second D2H
> register command fails in the function fails.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

This isn't exactly a command execution and the success condition
checks are performed manually afterwards.  The ignoring of command
execution result is intentional there and the proposed change is
likely to cause more harm than good.  Unless there are specific cases
where the new code would behave better, I'd much rather leave it as it
is.

Thansk.

-- 
tejun
