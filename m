From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v2 2/3] ata: ahci-platform: Add ports-implemented DT
 bindings.
Date: Thu, 31 Mar 2016 13:23:54 -0500
Message-ID: <20160331182354.GB8252@hector.attlocal.net>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33944 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757474AbcCaSX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2016 14:23:56 -0400
Received: by mail-ob0-f179.google.com with SMTP id kf9so104164459obc.1
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2016 11:23:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459445500-9071-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com

On Thu, Mar 31, 2016 at 06:31:39PM +0100, Srinivas Kandagatla wrote:
> On some SOCs PORTS_IMPL register value is never programmed by the
> firmware and left at zero value. Which means that no sata ports are
> available for software. AHCI driver used to cope up with this by
> fabricating the port_map if the PORTS_IMPL register is read zero,
> but recent patch broke this workaround as zero value was valid for
> NVMe disks.
> 
> This patch adds ports-implemented DT bindings as workaround for this issue
> in a way that DT can can override the PORTS_IMPL register in cases where
> the firmware did not program it already.
> 
> Fixes: 566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3)
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
