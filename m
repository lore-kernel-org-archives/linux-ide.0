From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] documentation: Update ide-cd documentation to reflect
 CONFIG_BLK_DEV_HD_IDE removal
Date: Thu, 12 Oct 2017 11:25:45 -0600
Message-ID: <20171012112545.674d3960@lwn.net>
References: <alpine.LNX.2.00.1710121439020.3@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:58318 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757445AbdJLRZr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 12 Oct 2017 13:25:47 -0400
In-Reply-To: <alpine.LNX.2.00.1710121439020.3@nippy.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-ide@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 12 Oct 2017 15:00:06 +1100 (AEDT)
Finn Thain <fthain@telegraphics.com.au> wrote:

> CONFIG_BLK_DEV_HD_IDE was removed in commit 80aa31cb460d ("ide: 
> remove CONFIG_BLK_DEV_HD_IDE config option (take 2)") but the ide-cd 
> documentation was not updated and still asks users to disable it, 
> which is misleading and involves a fruitless search.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied to the docs tree, thanks.

jon
