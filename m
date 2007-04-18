From: Max Kellermann <max@duempel.org>
Subject: Re: [PATCH] libata: add Samsung HD401LJ to the NCQ blacklist
Date: Wed, 18 Apr 2007 09:48:59 +0200
Message-ID: <20070418074859.GA21494@roonstrasse.net>
References: <20070418061541.GA11293@roonstrasse.net> <4625BA1A.9030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from duempel.org ([81.209.165.42]:49731 "HELO duempel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932962AbXDRHte (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Apr 2007 03:49:34 -0400
Content-Disposition: inline
In-Reply-To: <4625BA1A.9030808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 2007/04/18 08:26, Tejun Heo <htejun@gmail.com> wrote:
> Can you try it on another controller?  Say, a ahci or sil24?

Seems to work ok on a Via VT8251 controller (AHCI) on kernel
2.6.21-rc6-git4 without my NCQ disabling patch.

By the way, on this machine, I had a lot of SATA timeouts during
kernel boot, which were solved by appending "nomsi".  Do you believe
there might be a relation to the NCQ problems on my first (Nforce)
machine?

Max

