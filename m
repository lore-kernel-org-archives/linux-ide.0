From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: update documentation for sysfs interfaces
Date: Tue, 13 Feb 2018 06:41:26 -0800
Message-ID: <20180213144126.GN695913@devbig577.frc2.facebook.com>
References: <20180213081816.GA11350@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35806 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933716AbeBMOla (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2018 09:41:30 -0500
Content-Disposition: inline
In-Reply-To: <20180213081816.GA11350@mordor.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>

On Tue, Feb 13, 2018 at 01:48:16PM +0530, Aishwarya Pant wrote:
> Dcoumentation has been added by parsing through git commit history and
> reading code. This might be useful for scripting and tracking changes in
> the ABI.
> 
> I do not have complete descriptions for the following 3 attributes; they
> have been annotated with the comment [to be documented] -
> 
> 	/sys/class/scsi_host/hostX/ahci_port_cmd
> 	/sys/class/scsi_host/hostX/ahci_host_caps
> 	/sys/class/scsi_host/hostX/ahci_host_cap2
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
