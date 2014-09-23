From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND v3 2/6] AHCI: Move host activation code into
 ahci_host_activate()
Date: Tue, 23 Sep 2014 16:55:43 -0400
Message-ID: <20140923205543.GA17332@mtj.dyndns.org>
References: <cover.1411297686.git.agordeev@redhat.com>
 <4dde1cd7e44724d464b87c14c6192dec52fc8b50.1411297686.git.agordeev@redhat.com>
 <20140923202247.GF14111@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33396 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138AbaIWUzr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2014 16:55:47 -0400
Content-Disposition: inline
In-Reply-To: <20140923202247.GF14111@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Sep 23, 2014 at 04:22:47PM -0400, Tejun Heo wrote:
> On Sun, Sep 21, 2014 at 03:19:25PM +0200, Alexander Gordeev wrote:
> > Currently host activation done by calling either function
> > ahci_host_activate() or ata_host_activate(). Consolidate
> > the code by only calling ahci_host_activate() for all AHCI
> > devices.
> > 
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > Cc: linux-ide@vger.kernel.org
> 
> Applied to libata/for-3.18.

Oops, build failure.  Reverting both patches.

Thanks.

-- 
tejun
