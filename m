From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: use setup_deferrable_timer
Date: Mon, 13 Mar 2017 13:07:57 -0400
Message-ID: <20170313170757.GB15709@htj.duckdns.org>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
 <7eff953a3a1eaa33e39692b18d59e6baecb189cc.1489060962.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34427 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbdCMRIA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2017 13:08:00 -0400
Content-Disposition: inline
In-Reply-To: <7eff953a3a1eaa33e39692b18d59e6baecb189cc.1489060962.git.geliangtang@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 11, 2017 at 08:47:01AM +0800, Geliang Tang wrote:
> Use setup_deferrable_timer() instead of init_timer_deferrable() to
> simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
