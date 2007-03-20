From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22 RESEND] Optional LED trigger for libata
Date: Tue, 20 Mar 2007 18:30:45 +0900
Message-ID: <45FFA9C5.1090403@gmail.com>
References: <20070320092612.82EF65B80F1@ganymede.vroon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:17405 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933410AbXCTJav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 05:30:51 -0400
Received: by nz-out-0506.google.com with SMTP id s1so821632nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 02:30:50 -0700 (PDT)
In-Reply-To: <20070320092612.82EF65B80F1@ganymede.vroon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tony Vroon wrote:
> This adds an optional wrapper around ata_ac_issue_prot that triggers the LED layer.
> This is used for the PMU LED on G5 towers (IDE trigger). My test platform is a 
> PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2 (sata_svw) controller.
> Now respun as a single patch, and the function name shortened as requested.
> 
> Signed-off-by: Tony Vroon <chainsaw@gentoo.org>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
