From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 07/19] ahci: st: Remove STiH416 dt example
Date: Fri, 23 Sep 2016 10:07:23 -0500
Message-ID: <20160923150723.GC9176@rob-hp-laptop>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-8-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33090 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035010AbcIWPHZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 23 Sep 2016 11:07:25 -0400
Content-Disposition: inline
In-Reply-To: <1473859677-9231-8-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org, lee.jones@linaro.org, tj@kernel.org, linux-ide@vger.kernel.org

On Wed, Sep 14, 2016 at 02:27:45PM +0100, Peter Griffin wrote:
> This platform is being removed from the kernel so remove
> the dt example.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <tj@kernel.org>
> Cc: <robh+dt@kernel.org>
> Cc: <linux-ide@vger.kernel.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-st.txt | 15 ---------------
>  1 file changed, 15 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
