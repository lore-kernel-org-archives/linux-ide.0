From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: constify of_device_id structures
Date: Mon, 6 Mar 2017 15:18:25 -0500
Message-ID: <20170306201825.GK19696@htj.duckdns.org>
References: <1488396808-12332-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34890 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbdCFU2A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Mar 2017 15:28:00 -0500
Content-Disposition: inline
In-Reply-To: <1488396808-12332-1-git-send-email-bhumirks@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 02, 2017 at 01:03:28AM +0530, Bhumika Goyal wrote:
> Declare of_device_id structures as const as they are either passed to
> the macro MODULE_DEVICE_TABLE or stored in the of_match_table field of a
> device_driver structure. This field is of type const, so of_device_id
> structures having this property can be made const too.
> 
> Cross compiled the files drivers/ata/pata_macio.c and
> drivers/ata/pata_mpc52xx.c for powerpc architecture.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
