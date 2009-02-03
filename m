From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 8/8] libata: implement HORKAGE_1_5_GBPS and apply it to
 WD My Book
Date: Mon, 02 Feb 2009 23:04:51 -0500
Message-ID: <4987C263.90000@garzik.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org> <1233228696-10562-9-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39861 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbZBCEEy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:04:54 -0500
In-Reply-To: <1233228696-10562-9-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> 3Gbps is often much more prone to transmission failures.  It's usually
> okay to let EH handle speed down after transmission failures but some
> WD My Book drives completely shutdown after certain transmission
> failures and after it only power cycling can revive them.  Combined
> with the fact that external drives often end up with cable assembly
> which is longer than usual and more likely to have intervening gender,
> this makes these drives very likely to shutdown under certain
> configurations virtually rendering them unusable.
> 
> This patch implements HOARKGE_1_5_GBPS and applies it to WD My Book
> such that 1.5Gbps is forced once the device is identified.
> 
> Please take a look at the following bz for related reports.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=9913
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

applied 1-8


