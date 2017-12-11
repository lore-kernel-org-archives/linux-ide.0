From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] ahci: Add PCI ids for Intel Bay Trail, Cherry Trail
 and Apollo Lake AHCI
Date: Mon, 11 Dec 2017 06:41:28 -0800
Message-ID: <20171211144128.GA2421075@devbig577.frc2.facebook.com>
References: <20171206154110.11548-1-hdegoede@redhat.com>
 <20171206154110.11548-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34804 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdLKOlc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2017 09:41:32 -0500
Content-Disposition: inline
In-Reply-To: <20171206154110.11548-3-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 06, 2017 at 04:41:09PM +0100, Hans de Goede wrote:
> Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
> SATA controllers. This commit is a preparation patch for allowing a
> different default sata link powermanagement policy for mobile chipsets.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied 1-2 to libata/for-4.16.

Thanks.

-- 
tejun
