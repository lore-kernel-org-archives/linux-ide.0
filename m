From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 performance weirdness
Date: Thu, 28 Dec 2006 12:55:04 +0900
Message-ID: <45934018.4090005@gmail.com>
References: <20061227134503.GD28939@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:14901 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbWL1DzO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 22:55:14 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4441587wxd
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 19:55:13 -0800 (PST)
In-Reply-To: <20061227134503.GD28939@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org

Robin H. Johnson wrote:
> I forward-ported Tejun's PMP patches to libata#upstream (my first attempt at it
> a few weeks ago failed, but this round works fine, tested at each branch
> stage), and in using them, I have noticed a bit of oddity.

Great, care to share them?

> While dmesg claims that 3.0Gbps was negotiated, the combined performance of the
> 5 disks never exceeds 1.5Gbps, no matter how I combine them. Is something in
> the driver overriding the 3Gbps speed bits somewhere?

Nope.  I'll ask SIMG.

-- 
tejun
