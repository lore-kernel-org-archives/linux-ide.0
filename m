From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 RESEND] ata_piix: minor typo and a printk fix
Date: Sun, 13 Oct 2013 16:18:50 -0400
Message-ID: <20131013201850.GG18075@htj.dyndns.org>
References: <524B0CE0.70202@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:51108 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab3JMUSx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Oct 2013 16:18:53 -0400
Received: by mail-qc0-f182.google.com with SMTP id n4so4345242qcx.41
        for <linux-ide@vger.kernel.org>; Sun, 13 Oct 2013 13:18:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <524B0CE0.70202@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Tue, Oct 01, 2013 at 07:56:48PM +0200, Levente Kurusa wrote:
> The patch fixes a printk() being cut in half, some typos
> and a change in comments to better reflect the specs.
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>

Applied to libata/for-3.13.

Thanks.

-- 
tejun
