From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ATA: fix a problem that ata port print_id is used	uninitialized
Date: Thu, 30 Jul 2009 13:33:19 +0900
Message-ID: <4A71228F.5040701@gmail.com>
References: <1248916316.2670.160.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:48809 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZG3EjD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jul 2009 00:39:03 -0400
Received: by pzk38 with SMTP id 38so289346pzk.33
        for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 21:39:02 -0700 (PDT)
In-Reply-To: <1248916316.2670.160.camel@rzhang-dt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

Zhang Rui wrote:
> fix a problem that ata port print_id is used uninitialized.
> 
> port print_id is initialized in ata_host_register, but it's
> used in ata_host_start.
> Now move it to ata_host_start, before it's invoked for the first time.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

The idea was to assign print_id after the port is pretty much
guaranteed to be registered successfully but doing it earlier
shouldn't harm anything really.  So,

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
