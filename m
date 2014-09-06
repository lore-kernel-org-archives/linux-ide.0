From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9 2/3] ahci_xgene: Skip the PHY and clock initialization
 if already configured by the firmware.
Date: Sat, 6 Sep 2014 11:27:46 +0900
Message-ID: <20140906022746.GA21579@mtj.dyndns.org>
References: <1409217682-5759-1-git-send-email-stripathi@apm.com>
 <1409217682-5759-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:45491 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaIFC1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Sep 2014 22:27:52 -0400
Content-Disposition: inline
In-Reply-To: <1409217682-5759-3-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

On Thu, Aug 28, 2014 at 02:51:21PM +0530, Suman Tripathi wrote:
> This patch implements the feature to skip the PHY and clock
> initialization if it is already configured by the firmware.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied to libata/for-3.17-fixes.

Thanks.

-- 
tejun
