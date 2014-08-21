From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7 3/3] ahci_xgene: Fix the link down in first attempt
 for the APM X-Gene SoC AHCI SATA host controller driver.
Date: Thu, 21 Aug 2014 09:14:39 -0500
Message-ID: <20140821141439.GB1766@mtj.dyndns.org>
References: <1408429911-1406-1-git-send-email-stripathi@apm.com>
 <1408429911-1406-4-git-send-email-stripathi@apm.com>
 <20140819154912.GC16480@htj.dyndns.org>
 <CAOHikRB6Kfg82ewx6e-a6SCvjt_ipSKuXLciS=nHA1EpZzXrYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:60582 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbaHUOOn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2014 10:14:43 -0400
Content-Disposition: inline
In-Reply-To: <CAOHikRB6Kfg82ewx6e-a6SCvjt_ipSKuXLciS=nHA1EpZzXrYA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Linux SCSI List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, patches@apm.com

On Thu, Aug 21, 2014 at 01:48:00PM +0530, Suman Tripathi wrote:
> [suman] : The problem is COMRESET didn't failed. I meant the hardreset is
> successful (return 0) but the device is not detected even if device is
> present due to speed negotiation failure. For that reason I check for the
> Pxstatus and retried.

Alright, please update the comment to explain what's going on.

Thanks.

-- 
tejun
