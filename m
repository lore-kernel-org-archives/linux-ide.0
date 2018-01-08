From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: constify pci_bits
Date: Mon, 8 Jan 2018 06:16:08 -0800
Message-ID: <20180108141608.GQ3668920@devbig577.frc2.facebook.com>
References: <b3ca2f147a9e0b52bfcaac891a7319bb2e039966.1514956322.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33222 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756822AbeAHOQM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2018 09:16:12 -0500
Content-Disposition: inline
In-Reply-To: <b3ca2f147a9e0b52bfcaac891a7319bb2e039966.1514956322.git.arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Jan 03, 2018 at 10:43:34AM +0530, Arvind Yadav wrote:
> pci_bits are not supposed to change at runtime. Functions
> pci_test_config_bits() working with const 'struct pci_bits'.
> So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
