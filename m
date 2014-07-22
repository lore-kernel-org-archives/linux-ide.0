From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sil24: Identify which card suffered IRQ status error
Date: Tue, 22 Jul 2014 10:09:44 -0400
Message-ID: <20140722140944.GB13851@htj.dyndns.org>
References: <20140722132800.952BA60250@zebedee.buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:47335 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaGVOJs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 10:09:48 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so6978852qgd.37
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2014 07:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140722132800.952BA60250@zebedee.buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 22, 2014 at 02:28:00PM +0100, Tim Small wrote:
> In machines with multiple Silicon Image 3124 and/or 3132 cards, there is no
> way to tell which card is the culprit when the sata_sil24 interrupt handler
> gets a bad status.
> 
> Tested-by: tim@seoss.co.uk
> Signed-off-by: tim@seoss.co.uk

Applied to libata/for-3.17.  Please use "Full Name <EMAIL>" for tags.

Thanks.

-- 
tejun
