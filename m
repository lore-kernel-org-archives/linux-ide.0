From: Tejun Heo <tj@kernel.org>
Subject: Re: nx6325 and frequent head unloads
Date: Mon, 29 Sep 2008 16:34:11 +0900
Message-ID: <48E084F3.8090609@kernel.org>
References: <20080919002701.1537ca54@incubo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41836 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYI2Hf6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:35:58 -0400
In-Reply-To: <20080919002701.1537ca54@incubo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "A. Klitzing" <aklitzing@online.de>
Cc: linux-ide@vger.kernel.org

A. Klitzing wrote:
> Hi there,
> 
> my harddrive has this problem [1], too. Here are the outputs of my
> notebook "HP nx6325 (EY351ET)".
> 
> Workaround: hdparm -B 254 /dev/sda
> But the hdd will be warmer than usual.

How much does the load cycle count increase per hour without the adjustment?

Thanks.

-- 
tejun
