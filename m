From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: don't ignore result code of ahci_reset_controller()
Date: Mon, 2 Oct 2017 12:21:55 -0700
Message-ID: <20171002192155.GD3301751@devbig577.frc2.facebook.com>
References: <20171002183124.17003-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:51823 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbdJBTV7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2017 15:21:59 -0400
Received: by mail-it0-f53.google.com with SMTP id v82so8678254itc.0
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2017 12:21:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171002183124.17003-1-ard.biesheuvel@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-ide@vger.kernel.org, graeme.gregory@linaro.org, leif.lindholm@linaro.org, daniel.thompson@Linaro.org

On Mon, Oct 02, 2017 at 07:31:24PM +0100, Ard Biesheuvel wrote:
> ahci_pci_reset_controller() calls ahci_reset_controller(), which may
> fail, but ignores the result code and always returns success. This
> may result in failures like below

Applied to libata/for-4.14-fixes.

Thanks.

-- 
tejun
