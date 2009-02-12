From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives which perform frequent head unloads under Linux
Date: Thu, 12 Feb 2009 10:52:18 +0900
Message-ID: <499380D2.5070306@kernel.org>
References: <200902031429.19457.fcartegnie@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45384 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbZBLBwK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 20:52:10 -0500
In-Reply-To: <200902031429.19457.fcartegnie@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Cartegnie <fcartegnie@free.fr>
Cc: linux-ide@vger.kernel.org

Francois Cartegnie wrote:
> MSI Megabook S425
> MK8025GAS (unload every 8/10sec)
> Workaround with APM to 254 (but doesn't disable totally).

>From the smartctl output,

  9 Power_On_Hours     ...      2791
193 Load_Cycle_Count   ...      100209

Which gives us 35.9 load cycles per hour which is kind of okay.  Is
this because you have been running the system with APM value adjusted?

Thanks.

-- 
tejun
