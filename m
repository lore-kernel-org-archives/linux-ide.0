From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH V3] ata: use pci_get_drvdata()
Date: Sun, 2 Jun 2013 22:23:07 -0700
Message-ID: <20130603052307.GG6071@mtj.dyndns.org>
References: <002001ce6017$fc023340$f40699c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:45839 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3FCFXN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 01:23:13 -0400
Received: by mail-qc0-f170.google.com with SMTP id s11so1950210qcw.29
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 22:23:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002001ce6017$fc023340$f40699c0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, 'Axel Lin' <axel.lin@ingics.com>

On Mon, Jun 03, 2013 at 02:05:36PM +0900, Jingoo Han wrote:
> Use the wrapper function for getting the driver data using pci_dev
> instead of using dev_get_drvdata() with &pdev->dev, so we can
> directly pass a struct pci_dev. This is a just cosmetic change
> to use the wrapper function such as pci_get_drvdata().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.11.  Thanks.

-- 
tejun
