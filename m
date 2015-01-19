From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Mon, 19 Jan 2015 09:13:36 -0500
Message-ID: <20150119141336.GB8140@htj.dyndns.org>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
 <20150116231302.18771.62862.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:55017 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbASONm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2015 09:13:42 -0500
Content-Disposition: inline
In-Reply-To: <20150116231302.18771.62862.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org

On Fri, Jan 16, 2015 at 03:13:02PM -0800, Dan Williams wrote:
> Ronny reports: https://bugzilla.kernel.org/show_bug.cgi?id=87101
>     "Since commit 8a4aeec8d "libata/ahci: accommodate tag ordered
>     controllers" the access to the harddisk on the first SATA-port is
>     failing on its first access. The access to the harddisk on the
>     second port is working normal.
> 
>     When reverting the above commit, access to both harddisks is working
>     fine again."
> 
> Maintain tag ordered submission as the default, but allow sata_sil24 to
> continue with the old behavior.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Reported-by: Ronny Hegewald <Ronny.Hegewald@online.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-3.18-fixes.

Thanks.

-- 
tejun
