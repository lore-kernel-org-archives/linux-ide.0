From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND v3 2/6] AHCI: Move host activation code into
 ahci_host_activate()
Date: Tue, 23 Sep 2014 16:22:47 -0400
Message-ID: <20140923202247.GF14111@mtj.dyndns.org>
References: <cover.1411297686.git.agordeev@redhat.com>
 <4dde1cd7e44724d464b87c14c6192dec52fc8b50.1411297686.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:56073 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbaIWUWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2014 16:22:52 -0400
Content-Disposition: inline
In-Reply-To: <4dde1cd7e44724d464b87c14c6192dec52fc8b50.1411297686.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Sep 21, 2014 at 03:19:25PM +0200, Alexander Gordeev wrote:
> Currently host activation done by calling either function
> ahci_host_activate() or ata_host_activate(). Consolidate
> the code by only calling ahci_host_activate() for all AHCI
> devices.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: linux-ide@vger.kernel.org

Applied to libata/for-3.18.

Thanks.

-- 
tejun
