From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: make ata_port_type const
Date: Mon, 2 Oct 2017 09:57:00 -0700
Message-ID: <20171002165700.GB3301751@devbig577.frc2.facebook.com>
References: <1506789640-10748-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52518 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdJBQ5F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2017 12:57:05 -0400
Content-Disposition: inline
In-Reply-To: <1506789640-10748-1-git-send-email-bhumirks@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Sep 30, 2017 at 10:10:40PM +0530, Bhumika Goyal wrote:
> Make this const as it is only stored in the const field of a device
> structure. Make the declaration in header const too.
> 
> Structure found using Coccinelle and changes done by hand.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
