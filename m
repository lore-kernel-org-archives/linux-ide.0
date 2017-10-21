From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_mv: remove a redundant assignment to pointer
 ehi
Date: Sat, 21 Oct 2017 09:25:57 -0700
Message-ID: <20171021162557.GS1302522@devbig577.frc2.facebook.com>
References: <20171016110011.11048-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:55869 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbdJUQ0A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2017 12:26:00 -0400
Content-Disposition: inline
In-Reply-To: <20171016110011.11048-1-colin.king@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 16, 2017 at 12:00:11PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer ehi is being assigned to a value that is never read
> and is redundant.  Clean up the code and move the ehi declaration
> and initialization to the code block where it is used. Cleans up
> clang warning: Value stored to 'ehi' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
