From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/3] ahci: add ports-implemented dt bindings
Date: Fri, 1 Apr 2016 10:44:06 -0400
Message-ID: <20160401144406.GS7822@mtj.duckdns.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32845 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcDAOoJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2016 10:44:09 -0400
Content-Disposition: inline
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com

On Fri, Apr 01, 2016 at 08:52:55AM +0100, Srinivas Kandagatla wrote:
> On some SOCs PORTS_IMPL register value is never programmed by the BIOS
> and left at zero value. Which means that no sata ports are available for
> software. AHCI driver used to cope up with this by fabricating the
> port_map if the PORTS_IMPL register is read zero, but recent patch [1]
> broke this workaround as zero value was valid for nvme disks.
> 
> This patch adds ports-implemented dt bindings as workaround for this issue
> in a way that DT can dictate the port_map incase where the SOCs does not
> program it already.

Applied all three patches to libata/for-4.6-fixes w/ stable cc'd.

Thanks.

-- 
tejun
