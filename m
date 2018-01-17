From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ata: ahci_brcm: Recover from failures to identify
 devices
Date: Wed, 17 Jan 2018 07:53:21 -0800
Message-ID: <20180117155321.GV3460072@devbig577.frc2.facebook.com>
References: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:47095 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeAQPxZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2018 10:53:25 -0500
Content-Disposition: inline
In-Reply-To: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Jan 11, 2018 at 05:31:06PM -0800, Florian Fainelli wrote:
> Hi Tejun, Kishon,
> 
> This patch series implement a recovery mechanism to work around a HW bug
> on Broadcom AHCI SATA controller subject to noise triggering a failure to
> identify hard drives.

Applied 1-2 to libata/for-4.16.

Thanks.

-- 
tejun
